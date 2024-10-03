import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/bank_card.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/cards_page_view_model.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_card),
        onPressed: () {
          print('pressed');
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          scale: 20,
        ),
      ),
      body: Consumer<CardsPageViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.cards.length,
            itemBuilder: (context, index) {
              BankCard cards = viewModel.cards[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black12,
                      width: 2,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, top: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cards.cardAlias,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () => print('delete'),
                              child: const Text(
                                'Kartı Sil',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/master.png',
                              scale: 14,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              '**** **** **** ${cards.lastFourDigits}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
