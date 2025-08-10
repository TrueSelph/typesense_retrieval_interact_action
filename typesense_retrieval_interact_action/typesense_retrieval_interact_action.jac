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

}