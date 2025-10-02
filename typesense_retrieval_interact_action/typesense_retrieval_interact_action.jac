import json;
import logging;
import traceback;
import from logging { Logger }
import from jivas.agent.action.retrieval_interact_action { RetrievalInteractAction }

node TypesenseRetrievalInteractAction(RetrievalInteractAction) {
    # Integrates with vector database for retrieval augmented generation tasks

    # set up logger
    static has logger:Logger = logging.getLogger(__name__);

    # the vector store action label bound to this retrieval action
    has vector_store_action:str = "TypesenseVectorStoreAction";
    has cache_interact_action:str = "CacheInteractAction";

    def execute(visitor: agent_graph_walker) {
        content_filter="";
        if cache_interact_action := self.get_agent().get_action(action_label=self.cache_interact_action) {
            cached_result = cache_interact_action.get_cached_response(visitor);
            if cached_result.get("message") {
                visitor.interaction_node.set_message(cached_result["message"]);
                return;
            }

            if cache_interact_action.can_use_cache_filter() {
                content_filter = "metadata.document_type:!=cache_response";
            }
        }


        # first prepare the query with context completion
        # prepare query using conversation history or fallback to original utterance
        query = self.process_query(visitor);

        if(not query) {
            # if no query is generated, return early
            return;
        }

        if not query.get("is_query", False) {
            # if the query is not a query, return early
            return;
        }

        # update interaction node with query and context data
        interaction_context = visitor.interaction_node.data_get(key=self.get_type());
        if not interaction_context {
            interaction_context = {};
        }
        interaction_context['query'] = query.get("query", visitor);

        # handle context, if any and queue directive
        if(context_data := self.retrieve_context(query = interaction_context['query'], filter=content_filter)) {

            context_directive = None;
            # add raw context to the interaction node
            interaction_context['context'] = context_data;
            # convert context data to JSON for composing the directive
            context_json = json.dumps(context_data);
            # prepare context directive
            context_directive = self.directive.format(context=context_json);
            # add the context directive to the interaction node
            visitor.interaction_node.add_directive(directive = context_directive);
        } else {
            directives = visitor.interaction_node.get_directives();
            if(not directives) {
                visitor.interaction_node.add_directive(directive = self.null_directive);
            }
        }

        visitor.interaction_node.data_set(key=self.get_type(), value=interaction_context);

    }

    def process_query(visitor: agent_graph_walker) -> dict {

        query = {};

        # grab the history, if any
        if (statements := visitor.frame_node.get_transcript_statements(interactions = self.history_size, max_statement_length = self.max_statement_length)) {

            prompt_messages = [];
            prompt_messages.extend(statements);
            prompt_messages.extend([{"human": visitor.utterance}]);
            prompt_messages.extend([{"system": self.query_completion_prompt}]);

            result = None;

            if(model_action := self.get_agent().get_action(action_label=self.model_action)) {

                 if( model_action_result := model_action.call_model(
                    prompt_messages = prompt_messages,
                    prompt_variables = {},
                    interaction_node = visitor.interaction_node,
                    model_name=self.model_name,
                    model_temperature=self.model_temperature,
                    model_max_tokens=self.model_max_tokens
                )) {
                    # add the resulting intent, if any to the interaction to trigger the relevant action(s)
                    query = model_action_result.get_json_result();
                }
            }
        } else {
            query = {
                "query": visitor.utterance,
                "is_query": True
            };
        }

        return query;
    }

}