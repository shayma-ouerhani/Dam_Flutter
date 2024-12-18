// import 'dart:math';
// import 'package:damdleaders_flutter/Controllers/HomeController.dart';
// import 'package:damdleaders_flutter/Models/Stats.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;


// class Statsview extends StatefulWidget {
//   @override
//   _StatsviewState createState() => _StatsviewState();
// }
// class _StatsviewState extends State<Statsview> with SingleTickerProviderStateMixin {
//   String selectedFilter = 'My Jobs Offer'; // Default filter
//   final HomeController postService = HomeController();
//   late Future<List<Stats>> statsFuture;
//   List<String> jobs = [];
//   List<double> applications = [];
  
// /************************ */

// /************************ */

//   late AnimationController _controller;
//   bool isDataProcessed = false; // Flag to ensure setState() is not called during build

//   @override
//   void initState() {
//     super.initState();
//     statsFuture = postService.fetchApplicationsPerPost("674cabd54603d2eeb31c56e3"); // Fetch stats
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _controller.forward();
//   }

//   // Process fetched data into chart-friendly lists
//   void processFetchedData(List<Stats> stats) {
//     if (isDataProcessed) return; // Avoid processing data more than once

//     setState(() {
//       jobs = stats.map((stat) => stat.postName).toList();
//       applications = stats.map((stat) => stat.postulations.toDouble()).toList();
//       isDataProcessed = true; // Mark data as processed
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// @override
// Widget build(BuildContext context) {
//   double width = MediaQuery.of(context).size.width;

//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Enhanced Charts'),
//       centerTitle: true,
//     ),
//     body: FutureBuilder<List<Stats>>(
//       future: statsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No data available'));
//         }

//         // Use WidgetsBinding.instance.addPostFrameCallback to call setState after the build is complete
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (!isDataProcessed) {
//             processFetchedData(snapshot.data!);
//           }
//         });

//         return Column(
//           children: [
//             const Divider(thickness: 1),






// /*
// // Pie Chart Section
// Expanded(
//   child: FadeTransition(
//     opacity: _controller, // Assuming _controller is your animation controller
//     child: Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text(
//             'Age Distribution of Candidates',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const SizedBox(height: 80),
//         Expanded(
//           child: PieChart(
//             PieChartData(
//               sections: List.generate(
//                 ageIntervals.length,
//                 (index) => PieChartSectionData(
//                   //value: ageIntervals[index],
//                   color: Colors.primaries[index % Colors.primaries.length],
//                   //title: '${ageIntervals[index].toStringAsFixed(1)}%', // Displaying percentage on the pie chart
//                   radius: width > 600 ? 60 : 50, // Adjust for larger screens
//                   titleStyle: TextStyle(
//                     fontSize: width > 600 ? 16 : 14, 
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               centerSpaceRadius: 50,
//               sectionsSpace: 2, // Space between pie chart sections
//             ),
//           ),
//         ),
//         // Age Intervals Legend
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(ageIntervals.length, (index) {
//               final label = ageIntervals[index];
//               final color = Colors.primaries[index % Colors.primaries.length];

//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 16,
//                       height: 16,
//                       decoration: BoxDecoration(
//                         color: color,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       label as String, // Displaying label for each age interval
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
//           */
//           const Divider(thickness: 1),














// /********************** */
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Center(
//           child: Text(
//             'Number of Applications per Job Offer',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Expanded(
//           child: LineChart(
//             LineChartData(
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: applications
//                       .asMap()
//                       .entries
//                       .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
//                       .toList(),
//                   isCurved: true,
//                   barWidth: 4,
//                   gradient: const LinearGradient(
//                     colors: [Colors.green, Colors.lightGreen],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   dotData: FlDotData(show: true),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.green.withOpacity(0.2),
//                         Colors.lightGreen.withOpacity(0.1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     getTitlesWidget: (value, meta) {
//                       return Text(
//                         value.toInt().toString(),
//                         style: const TextStyle(fontSize: 12),
//                       );
//                     },
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     getTitlesWidget: (value, meta) {
//                       int index = value.toInt();
//                       if (index >= 0 && index < jobs.length) {
//                         return Text(
//                           jobs[index],
//                           style: const TextStyle(fontSize: 10),
//                         );
//                       }
//                       return const Text('');
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
//             /********************** */























//             /*
//             Expanded(
//               child: FadeTransition(
//                 opacity: _controller,
//                 child: Column(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Number of Applications per Job Offer',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Expanded(
//                       child: LineChart(
//                         LineChartData(
//                           lineBarsData: [
//                             LineChartBarData(
//                               spots: applications
//                                   .asMap()
//                                   .entries
//                                   .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
//                                   .toList(),
//                               isCurved: true,
//                               barWidth: 4,
//                               gradient: const LinearGradient(
//                                 colors: [Colors.green, Colors.lightGreen],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                               ),
//                               dotData: FlDotData(show: true),
//                               belowBarData: BarAreaData(
//                                 show: true,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.green.withOpacity(0.2),
//                                     Colors.lightGreen.withOpacity(0.1),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                           titlesData: FlTitlesData(
//                             leftTitles: AxisTitles(
//                               sideTitles: SideTitles(
//                                 showTitles: true,
//                                 reservedSize: 40,
//                                 getTitlesWidget: (value, meta) {
//                                   return Text(
//                                     value.toInt().toString(),
//                                     style: const TextStyle(fontSize: 12),
//                                   );
//                                 },
//                               ),
//                             ),
//                             bottomTitles: AxisTitles(
//                               sideTitles: SideTitles(
//                                 showTitles: true,
//                                 reservedSize: 40,
//                                 getTitlesWidget: (value, meta) {
//                                   int index = value.toInt();
//                                   if (index >= 0 && index < jobs.length) {
//                                     return Text(
//                                       jobs[index],
//                                       style: const TextStyle(fontSize: 10),
//                                     );
//                                   }
//                                   return const Text('');
//                                 },
//                               ),
//                             ),
//                             topTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                             rightTitles: AxisTitles(
//                               sideTitles: SideTitles(showTitles: false),
//                             ),
//                           ),
//                           gridData: FlGridData(show: true),
//                           borderData: FlBorderData(
//                             border: const Border(
//                               left: BorderSide(color: Colors.black),
//                               bottom: BorderSide(color: Colors.black),
//                               top: BorderSide.none,
//                               right: BorderSide.none,
//                             ),
//                           ),
//                           minX: 0,
//                           maxX: applications.length.toDouble() - 1,
//                           minY: 0,
//                           maxY: applications.reduce(max) + 10,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),*/
//           ],
//         );
//       },
//     ),
//   );
// }
// }

import 'dart:math';
import 'package:damdleaders_flutter/Controllers/HomeController.dart';
import 'package:damdleaders_flutter/Models/Stats.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Statsview extends StatefulWidget {
  @override
  _StatsviewState createState() => _StatsviewState();
}

class _StatsviewState extends State<Statsview> with SingleTickerProviderStateMixin {
  final HomeController postService = HomeController();
  late Future<Map<String, dynamic>> statsFuture; // Updated to fetch stats and allScores together
  late AnimationController _controller;

  List<String> jobs = [];
  List<double> applications = [];
  List<int> scoreIntervals = [0, 0, 0, 0]; // Intervals: [0-25], [26-50], [51-75], [76-100]
  bool isDataProcessed = false;

  @override
  void initState() {
    super.initState();
    statsFuture = postService.fetchApplicationsPerPost("674cabd54603d2eeb31c56e3"); // Updated fetch
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Process data for charts
  void processFetchedData(List<Stats> stats, List<int> allScores) {
    if (isDataProcessed) return;

    setState(() {
      jobs = stats.map((stat) => stat.postName).toList();
      applications = stats.map((stat) => stat.postulations.toDouble()).toList();

      for (var score in allScores) {
        if (score >= 0 && score <= 25) {
          scoreIntervals[0]++;
        } else if (score >= 26 && score <= 50) {
          scoreIntervals[1]++;
        } else if (score >= 51 && score <= 75) {
          scoreIntervals[2]++;
        } else if (score >= 76 && score <= 100) {
          scoreIntervals[3]++;
        }
      }
      isDataProcessed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Stats View'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!['stats'].isEmpty) {
            return const Center(child: Text('No data available'));
          }

          // Extract stats and allScores from snapshot
          final List<Stats> stats = snapshot.data!['stats'];
          final List<int> allScores = snapshot.data!['allScores'];

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!isDataProcessed) {
              processFetchedData(stats, allScores);
            }
          });

          return Column(
            children: [
              const Divider(thickness: 1),
              // Pie Chart for Score Intervals
              Expanded(
                child: FadeTransition(
                  opacity: _controller,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Score Distribution',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sections: List.generate(4, (index) {
                              final List<String> labels = [
                                '0-25',
                                '26-50',
                                '51-75',
                                '76-100'
                              ];
                              final List<Color> colors = [
                                Colors.red,
                                Colors.orange,
                                Colors.blue,
                                Colors.green
                              ];

                              return PieChartSectionData(
                                value: scoreIntervals[index].toDouble(),
                                color: colors[index],
                                title: '${labels[index]} \n(${scoreIntervals[index]})',
                                radius: width > 600 ? 80 : 60,
                                titleStyle: TextStyle(
                                  fontSize: width > 600 ? 14 : 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }),
                            centerSpaceRadius: 50,
                            sectionsSpace: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 1),
              // Line Chart for Applications per Job Offer
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Number of Applications per Job Offer',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: applications
                                    .asMap()
                                    .entries
                                    .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                                    .toList(),
                                isCurved: true,
                                barWidth: 4,
                                gradient: const LinearGradient(
                                  colors: [Colors.green, Colors.lightGreen],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green.withOpacity(0.2),
                                      Colors.lightGreen.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) => Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index >= 0 && index < jobs.length) {
                                      return Text(
                                        jobs[index],
                                        style: const TextStyle(fontSize: 10),
                                      );
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles( // Disable titles on the top
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles( // Disable titles on the right
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
