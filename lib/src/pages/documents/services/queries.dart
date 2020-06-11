String getDocumentsQuery =  r'''
query {
    documents {
        _id
        title
        slug
        content
        documentId
        documentUrl
        updatedAtFormat
    }
}
''';