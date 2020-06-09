String addComplain = r'''
    mutation($description: String!, $type: ComplainTypes!, $pictures: [String] ) {
    addComplain(input: { description: $description, type: $type, pictures: $pictures }) {
        _id
        residencyId
        postedBy
        description
        type
        pictures
        fullFiles
        status
        reportId
        updatedAt
        updatedAtFormat
        createdAt
        isActive
    }
}
    ''';