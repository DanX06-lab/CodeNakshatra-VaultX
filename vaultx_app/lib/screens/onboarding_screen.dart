import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../themes/vaultx_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  void goNext() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: VaultXColors.background,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF8F7F5), Color(0xFFEBEAE9)],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: h * 0.022),

              const Text(
                "VAULTX",
                style: TextStyle(
                  color: VaultXColors.dark,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "S E C U R E   Y O U R   D I G I T A L   L E G A C Y",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: VaultXColors.textSecondary,
                  fontSize: 12,
                  letterSpacing: 2.1,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() => currentPage = index);
                  },
                  children: const [HeroSlide(), FeatureSlide()],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Dot(active: currentPage == 0),
                  const SizedBox(width: 8),
                  Dot(active: currentPage == 1),
                ],
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: GestureDetector(
                  onTap: goNext,
                  child: Container(
                    height: 62,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF483C35), Color(0xFFD1671F)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: VaultXColors.accent.withValues(alpha: 0.22),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 14),

                        const Text(
                          "Connect with MetaMask",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 28),
                color: VaultXColors.border,
              ),

              const SizedBox(height: 16),

              const Text(
                "S U P P O R T E D   N E T W O R K S",
                style: TextStyle(
                  color: VaultXColors.textSecondary,
                  fontSize: 12,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 16),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NetworkItem(icon: Icons.hive_outlined, text: "Ethereum"),
                  NetworkItem(
                    icon: Icons.account_tree_outlined,
                    text: "Polygon",
                  ),
                  NetworkItem(icon: Icons.hexagon_outlined, text: "Arbitrum"),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "© 2024 VAULTX FOUNDATION",
                style: TextStyle(
                  color: VaultXColors.textSecondary,
                  fontSize: 12,
                  letterSpacing: 4,
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroSlide extends StatelessWidget {
  const HeroSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: h * 0.035),
        const VaultIcon(size: 245),
        const Spacer(),

        const Text(
          "Your Crypto.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: VaultXColors.textPrimary,
            fontSize: 42,
            fontWeight: FontWeight.w900,
          ),
        ),

        Text(
          "Protected Forever.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.w900,
            color: VaultXColors.accent,
            shadows: [
              Shadow(
                color: VaultXColors.accent.withValues(alpha: 0.18),
                blurRadius: 18,
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 38),
          child: Text(
            "The ultimate safety net for your digital inheritance and fund recovery.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: VaultXColors.textSecondary,
              fontSize: 18,
              height: 1.4,
            ),
          ),
        ),

        const Spacer(),
      ],
    );
  }
}

class FeatureSlide extends StatelessWidget {
  const FeatureSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10),
        VaultIcon(size: 155),
        SizedBox(height: 18),

        FeatureCard(
          icon: Icons.account_tree_outlined,
          iconColor: VaultXColors.accent,
          title: "Smart Inheritance",
          desc: "Automated asset transfer to your heirs.",
        ),

        SizedBox(height: 12),

        FeatureCard(
          icon: Icons.verified_outlined,
          iconColor: VaultXColors.accent,
          title: "Inactivity Recovery",
          desc: "Safety triggers if you lose wallet access.",
        ),

        SizedBox(height: 12),

        FeatureCard(
          icon: Icons.groups_3_outlined,
          iconColor: VaultXColors.accent,
          title: "Multi-sig Protocols",
          desc: "Decentralized institutional-grade security.",
        ),

        SizedBox(height: 8),
      ],
    );
  }
}

class VaultIcon extends StatelessWidget {
  final double size;

  const VaultIcon({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: VaultXColors.accent.withValues(alpha: 0.18),
              ),
            ),
          ),
          Container(
            width: size * 0.78,
            height: size * 0.78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: VaultXColors.accent.withValues(alpha: 0.24),
              ),
            ),
          ),
          Transform.rotate(
            angle: 0.78,
            child: Container(
              width: size * 0.46,
              height: size * 0.46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: VaultXColors.accent.withValues(alpha: 0.28),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.security_rounded,
            size: size * 0.22,
            color: VaultXColors.accent,
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String desc;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: VaultXColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: iconColor, size: 25),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: VaultXColors.textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: VaultXColors.textSecondary,
                    fontSize: 13.5,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool active;

  const Dot({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: active ? 22 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: active
            ? VaultXColors.accent
            : VaultXColors.textSecondary.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class NetworkItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const NetworkItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: VaultXColors.textSecondary, size: 22),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: VaultXColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
