String getResidentes = r'''
query {
    usersDirectory {
        completeName
        phone
        fullFile
        departmentId {
            _id
            name
        }
    }
}
''';
String getPersonal = r''' 
query {
    personalDirectory {
        _id
        completeName
        phone
        jobTitle
        description
        fullFile
        personalSchedule
    }
}
''';

String getGeneral = r'''
query($category: String) {
    directories(category: $category) {
        _id
        title
        phone
        category
        description
        isActive
        updatedAtFormat
    }
}
    ''';

String addComment = r'''mutation($personalId: ID, $text: String!) {
    addComment(input: { text: $text, personalId: $personalId }) {
        _id
        personalId
        text
        postedAt
        postedAtFormatDate
        isActive
        postedById {
            _id
            completeName
            fullFile
        }
    }
}''';

String listPersonalComentsQuery = r'''
    query($bazaarId: ID, $wallId: ID, $commonAreaId: ID, $personalId: ID) {
    comments(params: { bazaarId: $bazaarId, wallId: $wallId, commonAreaId: $commonAreaId, personalId: $personalId }) {
        _id
        bazaarId
        wallId
        text
        replayIds {
            _id
            text
            postedById {
                _id
                completeName
            }
        }
        postedById {
            _id
            completeName
            fullFile
        }
        complainById
        postedAt
        postedAtFormatDate
        isActive
    }
}
    ''';