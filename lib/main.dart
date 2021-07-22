import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Election Results'),
          ),
          body: ElectionResults()),
    ),
  );
}

class ElectionResults extends StatefulWidget {
  ElectionResults({Key? key}) : super(key: key);

  @override
  _ElectionResultsState createState() => _ElectionResultsState();
}

class _ElectionResultsState extends State<ElectionResults> {
  late List<_StateElectionDetails> _stateWiseElectionResult;
  late List<TreemapColorMapper> _colorMappers;

  @override
  void initState() {
    _stateWiseElectionResult = <_StateElectionDetails>[
      const _StateElectionDetails(
          state: 'Washington',
          candidate: 'Joe Biden',
          party: 'Democratic',
          totalVoters: 4087631,
          votes: 2369612,
          percentage: 57.97),
      const _StateElectionDetails(
          state: 'Oregon',
          candidate: 'Joe Biden',
          party: 'Democratic',
          totalVoters: 2374321,
          votes: 1340383,
          percentage: 56.45),
      const _StateElectionDetails(
          state: 'Alabama',
          candidate: 'Donald Trump',
          party: 'Republican',
          totalVoters: 2323282,
          votes: 1441170,
          percentage: 62.03),
      const _StateElectionDetails(
          state: 'Arizona',
          candidate: 'Joe Biden',
          party: 'Democratic',
          totalVoters: 3387326,
          votes: 1672143,
          percentage: 49.36),
      const _StateElectionDetails(
          state: 'Arkansas',
          candidate: 'Donald Trump',
          party: 'Republican',
          totalVoters: 1219069,
          votes: 760647,
          percentage: 62.40),
    ];

    //Define the color values for both parties
    _colorMappers = <TreemapColorMapper>[
      const TreemapColorMapper.value(value: 'Democratic', color: Colors.blue),
      const TreemapColorMapper.value(
          value: 'Republican', color: Colors.orangeAccent),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfTreemap(
            dataCount: _stateWiseElectionResult.length,
            weightValueMapper: (int index) {
              return _stateWiseElectionResult[index].totalVoters;
            },
            colorMappers: _colorMappers,
            levels: <TreemapLevel>[
              TreemapLevel(
                  groupMapper: (int index) =>
                      _stateWiseElectionResult[index].state,

                  // Update the state name in tiles.
                  labelBuilder: (BuildContext context, TreemapTile tile) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tile.group,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },

                  //Update the color of tiles representing the winning party
                  colorValueMapper: (TreemapTile tile) {
                    return _stateWiseElectionResult[tile.indices[0]].party;
                  },

                  // Enable the tooltip
                  tooltipBuilder: (BuildContext context, TreemapTile tile) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(
                              text: _stateWiseElectionResult[tile.indices[0]]
                                  .candidate,
                              children: <TextSpan>[
                            TextSpan(
                              text: '\n${tile.group}',
                            ),
                            TextSpan(
                              text: '\nWon percentage : ' +
                                  _stateWiseElectionResult[tile.indices[0]]
                                      .percentage
                                      .toString() +
                                  '%',
                            ),
                          ])),
                    );
                  }),
            ],

            // Enable the legend
            legend: TreemapLegend.bar(
              position: TreemapLegendPosition.bottom,
              segmentSize: const Size(80.0, 12.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _stateWiseElectionResult.clear();
    super.dispose();
  }
}

class _StateElectionDetails {
  const _StateElectionDetails(
      {required this.totalVoters,
      this.state,
      this.party,
      this.candidate,
      this.votes,
      this.percentage});

  final String? state;
  final double totalVoters;
  final String? party;
  final String? candidate;
  final double? votes;
  final double? percentage;
}
