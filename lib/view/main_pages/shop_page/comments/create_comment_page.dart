import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/widgets/custom_textfield.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/comments/create_comment_page_view_model.dart';

class CreateCommentPage extends StatelessWidget {
  CreateCommentPage({super.key, required this.productId});

  final TextEditingController _messageController = TextEditingController();

  String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yorum yap'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Ürünü aşağıdan puanlayabilir ve yorum yazabilirsiiniz.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(),
              _buildRatingBar(context),
              SizedBox(height: 8),
              _buildCommentTextField(),
              SizedBox(height: 8),
              _buildCreateCommentButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(BuildContext context) {
    CreateCommentPageViewModel viewModel = Provider.of(context, listen: false);

    return RatingBar.builder(
      itemSize: 55,
      initialRating: 0,
      minRating: 1,
      maxRating: 5,
      allowHalfRating: false,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
      onRatingUpdate: (value) {
        viewModel.setRaiting(value.toInt());
      },
    );
  }

  Widget _buildCreateCommentButton(BuildContext context) {
    CreateCommentPageViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
      label: "Yorum Yap",
      labelColor: Colors.white,
      buttonColor: Theme.of(context).colorScheme.primary,
      minWidth: double.infinity,
      minHeight: 50,
      onPressed: () {
        viewModel.createComment(
            context, _messageController.text, viewModel.raiting, productId);
      },
    );
  }

  Widget _buildCommentTextField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: CustomTextField(
        controller: _messageController,
        label: "Yorumunuz",
        maxLines: 5,
        isAlignLabel: true,
      ),
    );
  }
}
