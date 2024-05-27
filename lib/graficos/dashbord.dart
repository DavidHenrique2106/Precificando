import 'package:flutter/material.dart';
import 'package:flora/ingredientes/model/ingredientsPage.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RelatoriosScreen extends StatelessWidget {
  // Dados que estão vindo de outras telas
  final double totalVendasNoMes = 50000; //dados vindos de uma tela de vendas
  final double totalSaida = 20000; //  dados vindos de uma tela de despesas
  final double lucroBruto = 30000; // Calculado: totalVendasNoMes - totalSaida
  final double lucroLiquido = 25000; //  lucroBruto - impostos e outras deduções

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relatórios',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF8397FF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => IngredientListPage()),
            );
          },
        ),
      ),
      body: Container(
        color: Color(0xFFE8EBFF), // Cor de fundo AppBar
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total de Vendas no Mês: \$${totalVendasNoMes.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Total de Saídas: \$${totalSaida.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Lucro Bruto: \$${lucroBruto.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Lucro Líquido: \$${lucroLiquido.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Expanded(
              child: charts.BarChart(
                _createSampleData(),
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // dados de exemplo para o gráfico
  static List<charts.Series<SalesData, String>> _createSampleData() {
    final data = [
      SalesData('Jan', 5000),
      SalesData('Feb', 25000),
      SalesData('Mar', 10000),
      SalesData('Apr', 20000),
      SalesData('May', 30000),
      SalesData('Jun', 45000),
      SalesData('Jul', 35000),
      SalesData('Aug', 40000),
      SalesData('Sep', 20000),
      SalesData('Oct', 30000),
      SalesData('Nov', 45000),
      SalesData('Dec', 50000),
    ];

    return [
      charts.Series<SalesData, String>(
        id: 'Vendas',
        colorFn: (SalesData sales, _) =>
            charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SalesData sales, _) => sales.month,
        measureFn: (SalesData sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}
