import 'package:flutter/material.dart';
import 'package:copa_party/services/firebase_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Instância do FirebaseService
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe52d27), Color(0xFFb31217)], // vermelho gradiente
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Ícones de fundo
            Positioned(
              top: 80,
              right: -30,
              child: Opacity(
                opacity: 0.2,
                child: Icon(
                  Icons.sports_soccer,
                  size: 200,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -20,
              child: Opacity(
                opacity: 0.2,
                child: Icon(
                  Icons.celebration,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),

            // Conteúdo principal
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Icon(
                      Icons.sports_soccer,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 24),

                    // Título
                    const Text(
                      "Copa Party",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtítulo
                    Text(
                      "Entre para comemorar com a galera!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Botão Google
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/google_logo.png', // coloque o logo na pasta assets
                          height: 24,
                          width: 24,
                        ),
                        label: const Text(
                          "Entrar com Google",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () async {
                          final user = await _firebaseService.signInWithGoogle();
                          if (user != null) {
                            print("Usuário Google logado: ${user.displayName}");
                            // Redirecione para a próxima tela aqui
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botão login anônimo
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.person_outline),
                        label: const Text(
                          "Entrar Anônimo",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red.shade700,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () async {
                          final user = await _firebaseService.signInAnonymously();
                          if (user != null) {
                            print("Usuário anônimo logado: ${user.uid}");
                            // Redirecione para a próxima tela aqui
                          }
                        },
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
}
