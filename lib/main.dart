import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Excess Baggage Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// HOME PAGE

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  String ticketClass = 'Economy';

  String excessWeight = '0.00';
  String excessCharge = '0.00';
  String totalPayable = '0.00';
  String errorMessage = '';

  // CALCULATE BAGGAGE

  void calculateBaggage() {
    double? weight = double.tryParse(weightController.text.trim());
    double? rate = double.tryParse(rateController.text.trim());

    if (weight == null || rate == null) {
      setState(() {
        errorMessage = 'Please enter baggage weight and rate.';
      });
      return;
    }

    if (weight < 0 || rate < 0) {
      setState(() {
        errorMessage = 'Please enter positive numbers or zero.';
      });
      return;
    }

    double allowance = 20;

    if (ticketClass == 'Business') {
      allowance = 40;
    }

    double extra = weight - allowance;

    if (extra < 0) {
      extra = 0;
    }

    double charge = extra * rate;
    double total = charge + (charge * 0.08);

    setState(() {
      excessWeight = extra.toStringAsFixed(2);
      excessCharge = charge.toStringAsFixed(2);
      totalPayable = total.toStringAsFixed(2);
      errorMessage = '';
    });
  }

  // CLEAR BUTTON

  void clearAll() {
    setState(() {
      weightController.clear();
      rateController.clear();
      ticketClass = 'Economy';
      excessWeight = '0.00';
      excessCharge = '0.00';
      totalPayable = '0.00';
      errorMessage = '';
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TITLE BAR

      appBar: AppBar(
        title: const Text('Excess Baggage Calculator'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      // NAVIGATION MENU

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.luggage,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Baggage Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // MAIN CONTENT

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.luggage,
                size: 65,
                color: Colors.teal,
              ),

              const SizedBox(height: 10),

              const Text(
                'Baggage Fee Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Enter your baggage details to calculate '
                    'the excess baggage fee.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              // BAGGAGE WEIGHT INPUT

              TextField(
                controller: weightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Baggage Weight (kg)',
                  hintText: 'Example: 25',
                  prefixIcon: Icon(Icons.scale),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // TICKET CLASS INPUT

              DropdownButtonFormField<String>(
                value: ticketClass,
                decoration: const InputDecoration(
                  labelText: 'Ticket Class',
                  prefixIcon: Icon(Icons.flight),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Economy',
                    child: Text('Economy (20 kg)'),
                  ),
                  DropdownMenuItem(
                    value: 'Business',
                    child: Text('Business (40 kg)'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    ticketClass = value!;
                  });
                },
              ),

              const SizedBox(height: 15),

              // EXCESS RATE INPUT

              TextField(
                controller: rateController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Excess Rate per kg (RM)',
                  hintText: 'Example: 15',
                  prefixIcon: Icon(Icons.payments),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // CALCULATE BUTTON

              ElevatedButton.icon(
                onPressed: calculateBaggage,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate'),
              ),

              // CLEAR BUTTON

              OutlinedButton.icon(
                onPressed: clearAll,
                icon: const Icon(Icons.refresh),
                label: const Text('Clear'),
              ),

              const SizedBox(height: 10),

              // ERROR MESSAGE

              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              const SizedBox(height: 15),

              const Divider(),

              // RESULTS

              const Text(
                'Calculation Results',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Excess Baggage Weight: $excessWeight kg',
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 10),

              Text(
                'Excess Baggage Charge: RM $excessCharge',
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 10),

              Text(
                'Total Amount Payable: RM $totalPayable',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              const SizedBox(height: 20),

              // INSTRUCTIONS

              const Text(
                'Note: Economy allows 20 kg and Business '
                    'allows 40 kg. An 8% service tax applies '
                    'to excess baggage charges.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ABOUT PAGE

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.luggage,
                size: 90,
                color: Colors.teal,
              ),

              const SizedBox(height: 15),

              const Text(
                'Excess Baggage Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'This application helps users calculate '
                    'excess baggage fees for air travel.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              const Divider(),

              const Text(
                'Author Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const ListTile(
                leading: Icon(Icons.person),
                title: Text('Name'),
                subtitle: Text('Your Name'),
              ),

              const ListTile(
                leading: Icon(Icons.badge),
                title: Text('Matric Number'),
                subtitle: Text('Your Matric Number'),
              ),

              const ListTile(
                leading: Icon(Icons.school),
                title: Text('Course'),
                subtitle: Text('ICT602 - Mobile Technology'),
              ),

              const SizedBox(height: 20),

              const Divider(),

              const Text(
                'GitHub Repository',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'GitHub repository link will be added next.',
              ),

              const SizedBox(height: 30),

              const Divider(),

              const Text(
                'Copyright © 2026',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
