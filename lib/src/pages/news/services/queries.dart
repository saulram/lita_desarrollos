
String getNewsQuery = r''' query {
    news {
        residencyId
        _id
        title
        description
        images
        fullFiles
        isActive
        createdAt
        updatedAt
        updatedAtFormat
    }
} ''';