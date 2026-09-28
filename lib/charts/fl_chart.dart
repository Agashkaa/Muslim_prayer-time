import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sahypam/Helper/Frostedglass.dart';

class LineChartSample2 extends StatelessWidget {
  const LineChartSample2({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.50,
        child: Container(
          width: double.infinity,
          child: LineChart(
            LineChartData(
              // Setkalary sazlamak
              gridData: const FlGridData(show: true),
              // Grafik gyralarynyň çyzgylary
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d)),
              ),
              // Grafik oklarynyň iň pes we iň ýokary çäkleri
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 6,
              // Gapdaldaky ýazgylary (görkezijileri) sazlamak
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // X okundaky aýlaryň atlary
                      switch (value.toInt()) {
                        case 2: return const Text('MAR');
                        case 5: return const Text('JUN');
                        case 8: return const Text('SEP');
                        default: return const Text('');
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      // Y okundaky mukdar görkezijileri
                      switch (value.toInt()) {
                        case 1: return const Text('10K');
                        case 3: return const Text('30K');
                        case 5: return const Text('50K');
                        default: return const Text('');
                      }
                    },
                  ),
                ),
              ),
              // Grafigiň çyzgysy we nokatlary
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 3),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 3.1),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                  isCurved: true, // Çyzgy dugaly (egri) bolar ýaly
                  barWidth: 5,
                  color: Colors.blue, // Çyzgynyň reňki
                  dotData: const FlDotData(show: true), // Nokatlary gizlemek
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.2), // Çyzgynyň aşagyny reňklemek
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
