// Detail page untuk menampilkan informasi tentang sebuah pokemon
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final int id;
  final String imageUrl;
  final String type;

  const DetailPage({
    super.key,
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.type,
  });
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getTypeColor(String type) {
    //warna berdasarkan setiap tipe pokemon
    switch (type.toLowerCase()) {
      case 'grass':
        return Color(0xFF78C850);
      case 'fire':
        return Color(0xFFF08030);
      case 'water':
        return Color(0xFF6890F0);
      case 'electric':
        return Color(0xFFF8D030);
      case 'ice':
        return Color(0xFF98D8D8);
      case 'fighting':
        return Color(0xFFC03028);
      case 'poison':
        return Color(0xFFA040A0);
      case 'ground':
        return Color(0xFFE0C068);
      case 'flying':
        return Color(0xFFA890F0);
      case 'psychic':
        return Color(0xFFF85888);
      case 'bug':
        return Color(0xFFA8B820);
      case 'rock':
        return Color(0xFFB8A038);
      case 'ghost':
        return Color(0xFF705898);
      case 'dragon':
        return Color(0xFF7038F8);
      case 'dark':
        return Color(0xFF705848);
      case 'steel':
        return Color(0xFFB8B8D0);
      case 'fairy':
        return Color(0xFFEE99AC);
      default:
        return Color(0xFFA8A878);
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(widget.type);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: 28),
                  ),
                  Spacer(),
                  Text(
                    '#${widget.id.toString().padLeft(3, '0')}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                color: typeColor.withValues(alpha: 0.15),
                child: Center(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.contain,
                    width: 250,
                    height: 250,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported, size: 80);
                    },
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: typeColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              widget.type,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    TabBar(
                      // Tab navigasi untuk berbagai informasi pokemon
                      controller: _tabController,
                      labelColor: typeColor,
                      unselectedLabelColor: Colors.grey[400],
                      indicatorColor: typeColor,
                      tabs: [
                        Tab(text: 'Forms'),
                        Tab(text: 'Detail'),
                        Tab(text: 'Type'),
                        Tab(text: 'Stats'),
                        Tab(text: 'Weakness'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildFormsTab(typeColor),
                          _buildDetailTab(typeColor),
                          _buildTypesTab(typeColor),
                          _buildStatsTab(typeColor),
                          _buildWeaknessTab(typeColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormsTab(Color typeColor) {
    // Tab menampilakn berbagai form
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Forms',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: typeColor, width: 2),
                ),
                child: Center(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported);
                    },
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mega Evolution',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'In order to support its flower, which has grown larger due to Mega Evolution, its back and legs have become stronger.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailTab(typeColor) {
    // Tab menampilkan informasi detail pokemon
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection('Basic Information', [
            ('Name', widget.name),
            ('ID', '#${widget.id.toString().padLeft(3, '0')}'),
            ('Type', widget.type),
            ('Height', '1.0 m'),
            ('Weight', '6.9 kg'),
          ]),
          SizedBox(height: 20),
          _buildInfoSection('Abilities', [
            ('Primary', 'Overgrow'),
            ('Hidden', 'Chlorophyll'),
          ]),
        ],
      ),
    );
  }

  Widget _buildTypesTab(Color typeColor) {
    // Tab menampilkan  informasi tipe pokemon
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildTypeCard(widget.type, typeColor),
          SizedBox(height: 16),
          Text(
            'Type characteristics:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Grass-type Pokémon are typically associated with plants, herbs, and nature.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab(Color typeColor) {
    // Tab menampilkan base stats
    final stats = [
      ('HP', 45),
      ('Attack', 49),
      ('Defense', 49),
      ('Sp. Atk', 65),
      ('Sp. Def', 65),
      ('Speed', 45),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Base Stats',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          ...stats.map((stat) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stat.$1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      '${stat.$2}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: stat.$2 / 150,
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(typeColor),
                  ),
                ),
                SizedBox(height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeaknessTab(Color typeColor) {
    // Tab menampilkan kelemahan  dan resistensi
    final weaknesses = ['Fire', 'Ice', 'Poison', 'Flying', 'Bug'];
    final resistances = ['Ground', 'Water', 'Grass'];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weaknesses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: weaknesses
                .map((weakness) => _buildTypeChip(weakness))
                .toList(),
          ),
          SizedBox(height: 24),
          Text(
            'Resistances',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: resistances
                .map((resistance) => _buildTypeChip(resistance))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<(String, String)> items) {
    // helper method untuk info section dengan label dan value
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              ...items.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.$1,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          item.$2,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    if (index < items.length - 1) ...[
                      SizedBox(height: 12),
                      Divider(height: 0),
                      SizedBox(height: 12),
                    ],
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypeCard(String type, Color typeColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: typeColor.withValues(alpha: 0.1),
        border: Border.all(color: typeColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Primary Type',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    final chipColor = _getTypeColor(type);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
