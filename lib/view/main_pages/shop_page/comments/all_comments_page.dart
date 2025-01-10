import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/comment.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/comments/all_comments_page_view_model.dart';

class AllCommentsPage extends StatelessWidget {
  AllCommentsPage({super.key, required this.productId});

  String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildAddCommentFloatingActionButton(context),
      appBar: AppBar(
        title: Text("Tüm Yorumlar"),
        centerTitle: true,
      ),
      body: _buildCommentsList(),
    );
  }

  FloatingActionButton _buildAddCommentFloatingActionButton(context) {
    AllCommentsPageViewModel viewModel = Provider.of(context, listen: false);
    return FloatingActionButton(
      onPressed: () {
        viewModel.goAddCommentPage(context, productId);
      },
      child: Icon(Icons.add_comment_rounded),
    );
  }

  Widget _buildCommentsList() {
    return Consumer<AllCommentsPageViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          itemCount: viewModel.comments.length,
          itemBuilder: (context, index) {
            Comment cm = viewModel.comments[index];
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRatingStars(cm.rating),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(cm.userId['name']),
                          ),
                        ],
                      ),
                      Text(cm.formattedCreatedAt)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    cm.comment,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Sadece gerekli alanı kaplar
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          // Dolu veya boş yıldız
          color: Colors.amber, // Yıldız rengi
          size: 20, // Yıldız boyutu
        );
      }),
    );
  }
}
