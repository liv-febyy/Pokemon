import 'package:camera_flutter/detail_page.dart';
import 'package:camera_flutter/Model/dummy_data.dart';
import 'package:camera_flutter/pokemon_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final searchName = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerText(),
              SizedBox(height: 20),
              searchBar(searchName),
              SizedBox(height: 20),
              listPokemon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "pokedex",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Text(
          'Search for a pokemon by name or using its National pokedex number.',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget searchBar(TextEditingController searchName) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: TextFormField(
            controller: searchName,
            decoration: InputDecoration(
              hintText: 'Search Pokemon by name or number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey,
          ),
          child: Icon(Icons.filter_list),
        ),
      ],
    );
  }

  Widget listPokemon() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 8,
        ),
        itemCount: dummyPokemonList.length,
        itemBuilder: (context, index) {
          return Pokemoncardwidget(
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    name: dummyPokemonList[index].name,
                    id: dummyPokemonList[index].id,
                    imageUrl: dummyPokemonList[index].imageUrl,
                    type: dummyPokemonList[index].type,
                  ),
                ),
              );
            },
            imageUrl: dummyPokemonList[index].imageUrl,
            name: dummyPokemonList[index].name,
            type: dummyPokemonList[index].type,
          );
        },
      ),
    );
  }
}
