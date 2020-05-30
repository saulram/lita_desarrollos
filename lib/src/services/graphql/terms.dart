String getTerms = r'''
query($slug: String!) {
    globalContent(slug: $slug) {
        _id
        title
        slug
        content
        createdAt
        updatedAtFormatDate
        isActive
    }
}
''';
