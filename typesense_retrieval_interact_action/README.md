# Typesense Retrieval Interact Action

![GitHub release (latest by date)](https://img.shields.io/github/v/release/TrueSelph/typesense_retrieval_interact_action)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/TrueSelph/typesense_retrieval_interact_action/test-action.yaml)
![GitHub issues](https://img.shields.io/github/issues/TrueSelph/typesense_retrieval_interact_action)
![GitHub pull requests](https://img.shields.io/github/issues-pr/TrueSelph/typesense_retrieval_interact_action)
![GitHub](https://img.shields.io/github/license/TrueSelph/typesense_retrieval_interact_action)

JIVAS action for performing retrieval operations against the Typesense vector store, supporting retrieval-augmented generation tasks. As a core interact action, it plays a pivotal role in enhancing data retrieval processes and generating comprehensive results for queries. Configured as a singleton, it requires the Jivas library version 2.0.0 and depends on both `persona_interact_action` and `typesense_vector_store_action` for its functionality.

## Package Information

- **Name:** `jivas/typesense_retrieval_interact_action`
- **Author:** [V75 Inc.](https://v75inc.com/)
- **Architype:** `TypesenseRetrievalInteractAction`

## Meta Information

- **Title:** Typesense Retrieval Interact Action
- **Group:** core
- **Type:** interact_action

## Configuration

- **Singleton:** true
- **Order:**
  - **Weight:** 0
  - **Before:** `jivas/persona_interact_action`

## Dependencies

- **Jivas:** `^2.0.0`
- **Actions:**
  - `jivas/persona_interact_action`: `>=0.0.1`
  - `jivas/typesense_vector_store_action`: `>=0.0.1`

---

## How to Use

Below is detailed guidance on how to configure and use the Typesense Retrieval Interact Action.

### Overview

The Typesense Retrieval Interact Action provides an abstraction layer for interacting with the Typesense store. It supports multiple configurations for various use cases, including:

- **Custom retrieval tasks** for specific queries.
- **Integration** with Typesense vector stores.
- **Pipeline management** for chaining retrieval and generation tasks.

---

### Configuration Structure

The configuration consists of the following components:

### `vector_store_action`

Defines the vector store action label bound to this retrieval action.

```python
vector_store_action = "TypesenseVectorStoreAction"
```

---

### Example Configurations

### Basic Configuration for Typesense

```python
vector_store_action = "TypesenseVectorStoreAction"
```

### Best Practices
- Ensure the vector store action is properly configured and accessible.
- Test retrieval pipelines in a staging environment before production use.

---

## 🔰 Contributing

- **🐛 [Report Issues](https://github.com/TrueSelph/typesense_retrieval_interact_action/issues)**: Submit bugs found or log feature requests for the `typesense_retrieval_interact_action` project.
- **💡 [Submit Pull Requests](https://github.com/TrueSelph/typesense_retrieval_interact_action/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your GitHub account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/TrueSelph/typesense_retrieval_interact_action
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to GitHub**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details open>
<summary>Contributor Graph</summary>
<br>
<p align="left">
    <a href="https://github.com/TrueSelph/typesense_retrieval_interact_action/graphs/contributors">
        <img src="https://contrib.rocks/image?repo=TrueSelph/typesense_retrieval_interact_action" />
   </a>
</p>
</details>

## 🎗 License

This project is protected under the Apache License 2.0. See [LICENSE](../LICENSE) for more information.