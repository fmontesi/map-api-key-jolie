# API key template

A simple [Jolie](https://jolie-lang.org) implementation of the [API Key Microservice API pattern](https://microservice-api-patterns.org/patterns/quality/qualityManagementAndGovernance/APIKey).

## Story

You have a service, called FormatConverter, that allows clients to convert JSON data into XML and vice versa. The implementation in `no-api-key` performs no access control.

You decide after a while that you should use an API key to control access from clients. You have two options.
- Make an intrusive change in the code of FormatConverter, meaning that you change the code of the service to update its data model and implementation to validate API keys. This is given in `intrusive-api-key`.
- Make a non-intrusive change: leave the code of FormatConverter unchanged, and use instead an API gateway to implement the API key validation logic. This is exemplified in `non-intrusive-api-key`.
