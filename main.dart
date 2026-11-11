import 'package:flutter/material.dart';

void main() => runApp(const DzShopApp());

const gold = Color(0xFFD4AF37);
const black = Color(0xFF101010);

class DzShopApp extends StatelessWidget {
  const DzShopApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DZ SHOP 15',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black,
      colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
      useMaterial3: true,
    ),
    home: const StorePage(),
  );
}

class Item {
  final String name;
  final int price;
  final IconData icon;
  const Item(this.name, this.price, this.icon);
}

const items = [
  Item('Smartphone', 45900, Icons.phone_android),
  Item('Écouteurs sans fil', 7900, Icons.headphones),
  Item('Parfum élégant', 12500, Icons.spa),
  Item('Montre classique', 9800, Icons.watch),
  Item('Coffret chocolat', 6500, Icons.card_giftcard),
  Item('Enceinte Bluetooth', 11200, Icons.speaker),
];

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool arabic = true;
  final cart = <Item>[];

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: arabic ? TextDirection.rtl : TextDirection.ltr,
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('DZ SHOP 15', style: TextStyle(color: gold, fontWeight: FontWeight.w900, letterSpacing: 2)),
        actions: [
          TextButton(onPressed: () => setState(() => arabic = !arabic),
            child: Text(arabic ? 'FR' : 'عربي', style: const TextStyle(color: gold))),
          IconButton(onPressed: _showCart, icon: Badge(label: Text('${cart.length}'),
            child: const Icon(Icons.shopping_bag_outlined, color: gold))),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: gold),
            gradient: const LinearGradient(colors: [Color(0xFF302716), Color(0xFF111111)]),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('DZ SHOP 15', style: TextStyle(color: gold, fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text(arabic ? 'أناقتك واختياراتك… في مكان واحد' : 'Vos envies et votre style, au même endroit'),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(arabic ? 'اختر منتجك من القائمة' : 'Choisissez un produit'))),
              child: Text(arabic ? 'تسوّق الآن' : 'Acheter maintenant'),
            ),
          ]),
        ),
        const SizedBox(height: 24),
        Text(arabic ? 'الأقسام' : 'Catégories', style: const TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: [
          _chip(arabic ? 'هواتف' : 'Téléphones', Icons.phone_android),
          _chip(arabic ? 'إلكترونيات' : 'Électronique', Icons.devices),
          _chip(arabic ? 'عطور' : 'Parfums', Icons.spa),
          _chip(arabic ? 'حلويات' : 'Chocolats', Icons.cake),
        ]),
        const SizedBox(height: 24),
        Text(arabic ? 'عروض خاصة' : 'Offres spéciales', style: const TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(arabic ? 'ترقّبوا عروض DZ SHOP 15 قريباً.' : 'Les offres DZ SHOP 15 arrivent bientôt.'),
        const SizedBox(height: 24),
        Text(arabic ? 'الأكثر مبيعاً' : 'Meilleures ventes', style: const TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .72),
          itemBuilder: (_, i) => _product(items[i]),
        ),
        const SizedBox(height: 18),
        Center(child: Text(arabic ? 'التوصيل إلى 58 ولاية • الدفع عند الاستلام' : 'Livraison dans les 58 wilayas • Paiement à la livraison',
          textAlign: TextAlign.center, style: const TextStyle(color: gold, fontWeight: FontWeight.bold))),
        const SizedBox(height: 8),
        Center(child: Text(arabic ? 'سعر التوصيل يُؤكَّد هاتفياً' : 'Frais confirmés par téléphone',
          style: const TextStyle(color: Colors.white60, fontSize: 12))),
      ]),
    ),
  );

  Widget _chip(String label, IconData icon) => ActionChip(
    avatar: Icon(icon, color: gold, size: 18), label: Text(label),
    side: BorderSide(color: gold.withOpacity(.4)), onPressed: () {});

  Widget _product(Item item) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: const Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(16), border: Border.all(color: gold.withOpacity(.25))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(child: Container(
        decoration: BoxDecoration(color: const Color(0xFF292316), borderRadius: BorderRadius.circular(12)),
        child: Icon(item.icon, color: gold, size: 55))),
      const SizedBox(height: 8),
      Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text('${item.price} DA', style: const TextStyle(color: gold, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      OutlinedButton(
        style: OutlinedButton.styleFrom(foregroundColor: gold, side: const BorderSide(color: gold)),
        onPressed: () {
          setState(() => cart.add(item));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(arabic ? 'أُضيف المنتج إلى السلة' : 'Produit ajouté au panier')));
        },
        child: Text(arabic ? 'أضف إلى السلة' : 'Ajouter', style: const TextStyle(fontSize: 11)),
      ),
    ]),
  );

  void _showCart() => showModalBottomSheet(
    context: context, backgroundColor: const Color(0xFF1B1B1B),
    builder: (_) => Directionality(
      textDirection: arabic ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(arabic ? 'سلة المشتريات' : 'Votre panier',
            style: const TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
          if (cart.isEmpty) Text(arabic ? 'السلة فارغة' : 'Panier vide')
          else ...[
            ...cart.map((p) => ListTile(title: Text(p.name), trailing: Text('${p.price} DA'))),
            Text('${arabic ? 'المجموع' : 'Total'}: ${cart.fold<int>(0, (s, p) => s + p.price)} DA'),
            const SizedBox(height: 8),
            Text(arabic ? 'نسخة تجريبية: إتمام الطلب غير مفعّل بعد.' : 'Démo : validation de commande non activée.'),
          ],
        ]),
      )),
    ),
  );
}
