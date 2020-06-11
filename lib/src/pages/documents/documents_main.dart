import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/documents/services/documents_service.dart';
import 'package:litadesarrollos/src/pages/documents/widgets/document_card.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class DocumentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Documentos'),
      ),
      backgroundColor: Colors.white,
      endDrawer: DrawerLita(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: documentProvider.docs.documents != null
                ? RefreshIndicator(
                    onRefresh: documentProvider.getDocuments,
                    child: ListView.builder(
                        itemCount: documentProvider.docs.documents.length,
                        itemBuilder: (BuildContext ctx, int i) {
                          return DocCard(
                            doc: documentProvider.docs.documents[i],
                          );
                        }),
                  )
                : Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
