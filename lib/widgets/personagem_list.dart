import 'package:flutter/material.dart';

import '../pages/detalhes_page.dart';
import '../repositories/personagem_repository.dart';

class PersonagemList extends StatefulWidget {
  final double _contentPixelSize;
  PersonagemList(this._contentPixelSize);

  @override
  _PersonagemListState createState() => _PersonagemListState();
}

class _PersonagemListState extends State<PersonagemList> {
  late PersonagemRepository personagemRepository;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
  static const int cardHeight = 120;
  int _itensPerPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    personagemRepository = PersonagemRepository();
    loadPersonagens();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      loadPersonagens();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void loadPersonagens() async {
    loading.value = true;
    _itensPerPage = (widget._contentPixelSize/cardHeight).floor();
    await personagemRepository.getPersonagens(_itensPerPage);
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: personagemRepository,
        builder: (context, snapshot) {
          return Stack(
            children: [
              ListView.builder(
                  controller: _scrollController,
                  itemBuilder: ((context, index) => cardBuilder(context, index)),
                  itemCount: personagemRepository.personagens.length),
              loadingIndicatorWidget(),
            ],
          );
        });
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
            left: (MediaQuery.of(context).size.width / 2) - 20,
            bottom: 24,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          )
              : Container();
        });
  }

  Widget cardBuilder(BuildContext context, int index) {
    final personagem = personagemRepository.personagens[index];
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(personagem.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personagem.nome,
                      style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      personagem.classe,
                      style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      personagem.nacionalidade,
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalhesPage(personagem.id)));
      },
    );
  }
}

