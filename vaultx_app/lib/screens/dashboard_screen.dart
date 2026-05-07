import 'package:flutter/material.dart';
import '../themes/vaultx_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFA100FF),
        onPressed: () {
          debugPrint("Open VaultX AI");
        },
        child: const Icon(Icons.smart_toy_outlined, color: Colors.white),
      ),
      bottomNavigationBar: const VaultXBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              const SizedBox(height: 28),

              const Text(
                "Your Portfolio",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Real-time crypto holdings protected by VaultX",
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 15),
              ),

              const SizedBox(height: 18),
              const PortfolioCard(),

              const SizedBox(height: 24),
              const SectionTitle(title: "Quick Actions"),
              const SizedBox(height: 14),
              const QuickActions(),

              const SizedBox(height: 26),
              const StatusBanner(),

              const SizedBox(height: 18),
              const VaultStats(),

              const SizedBox(height: 28),
              const SectionTitle(
                title: "Recent Activity",
                rightText: "See All",
              ),
              const SizedBox(height: 14),
              const ActivityList(),

              const SizedBox(height: 28),
              const SectionTitle(title: "Beneficiaries", badge: "3 TOTAL"),
              const SizedBox(height: 14),
              const BeneficiaryList(),

              const SizedBox(height: 28),
              const SectionTitle(title: "Owner Controls"),
              const SizedBox(height: 14),
              const OwnerControls(),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.account_balance_wallet_outlined,
          color: Color(0xFF9BE7FF),
          size: 28,
        ),
        const SizedBox(width: 10),
        const Text(
          "VaultX",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: const Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: Color(0xFF22C55E)),
              SizedBox(width: 8),
              Text(
                "0X71C...4E21",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PortfolioCard extends StatelessWidget {
  const PortfolioCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TOTAL BALANCE",
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "\$42,870.45",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "+\$1,240.20 today",
            style: TextStyle(
              color: Color(0xFF4ADE80),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              CoinMiniCard(symbol: "ETH", amount: "12.45", value: "\$31,200"),
              SizedBox(width: 10),
              CoinMiniCard(symbol: "BTC", amount: "0.18", value: "\$11,420"),
              SizedBox(width: 10),
              CoinMiniCard(symbol: "USDC", amount: "250", value: "\$250"),
            ],
          ),
        ],
      ),
    );
  }
}

class CoinMiniCard extends StatelessWidget {
  final String symbol;
  final String amount;
  final String value;

  const CoinMiniCard({
    super.key,
    required this.symbol,
    required this.amount,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symbol,
              style: const TextStyle(
                color: Color(0xFF9BE7FF),
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
            Text(
              value,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBanner extends StatelessWidget {
  const StatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF9BE7FF).withValues(alpha: 0.25),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle_outline, color: Color(0xFF9BE7FF), size: 22),
          SizedBox(width: 12),
          Text(
            "Vault is active and secure.",
            style: TextStyle(
              color: Color(0xFFBAEFFF),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class VaultStats extends StatelessWidget {
  const VaultStats({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.45,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: const [
        StatCard(label: "VAULT STATE", value: "ACTIVE", greenDot: true),
        StatCard(label: "CONTRACT BALANCE", value: "32.45 ETH"),
        StatCard(label: "LAST CHECK-IN", value: "2 hours ago"),
        StatCard(
          label: "INACTIVITY TIMER",
          value: "5d 4h\nremaining",
          highlighted: true,
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final bool greenDot;
  final bool highlighted;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.greenDot = false,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      highlighted: highlighted,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 10),
          ),
          const Spacer(),
          Row(
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: highlighted ? const Color(0xFF9BE7FF) : Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (greenDot) ...[
                const SizedBox(width: 6),
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Color(0xFF22C55E),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        ActionButton(icon: Icons.north_east, text: "SEND"),
        SizedBox(width: 12),
        ActionButton(icon: Icons.swap_horiz, text: "SWAP"),
        SizedBox(width: 12),
        ActionButton(
          icon: Icons.favorite_border,
          text: "CHECK-IN",
          active: true,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool active;

  const ActionButton({
    super.key,
    required this.icon,
    required this.text,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFF9BE7FF)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: const Color(0xFF9BE7FF).withValues(alpha: 0.35),
                    blurRadius: 18,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? const Color(0xFF07111F) : const Color(0xFF9BE7FF),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                color: active ? const Color(0xFF07111F) : Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ActivityTile(
          icon: Icons.north_east,
          iconColor: Color(0xFFFF6B6B),
          title: "ETH Sent",
          subtitle: "Mar 24, 2024 · 14:22",
          amount: "-1.20 ETH",
          value: "-\$4,212.00",
        ),
        ActivityTile(
          icon: Icons.south_west,
          iconColor: Color(0xFF4ADE80),
          title: "ETH Received",
          subtitle: "Mar 23, 2024 · 09:15",
          amount: "+0.45 ETH",
          value: "+\$1,580.40",
          positive: true,
        ),
        ActivityTile(
          icon: Icons.update,
          iconColor: Color(0xFFC084FC),
          title: "Vault Check-In",
          subtitle: "Mar 22, 2024 · 18:45",
          amount: "Verified",
          value: "Timer Reset",
        ),
      ],
    );
  }
}

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String amount;
  final String value;
  final bool positive;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.value,
    this.positive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: positive ? const Color(0xFF4ADE80) : Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                value,
                style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BeneficiaryList extends StatelessWidget {
  const BeneficiaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BeneficiaryTile(address: "0x123...abcd", percent: "50%"),
        BeneficiaryTile(address: "0x456...efgh", percent: "25%"),
        BeneficiaryTile(address: "0x789...ijkl", percent: "25%"),
      ],
    );
  }
}

class BeneficiaryTile extends StatelessWidget {
  final String address;
  final String percent;

  const BeneficiaryTile({
    super.key,
    required this.address,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF1E293B),
            child: Icon(Icons.person_outline, color: Color(0xFF9BE7FF)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              address,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            percent,
            style: const TextStyle(
              color: Color(0xFF9BE7FF),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class OwnerControls extends StatelessWidget {
  const OwnerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_clock, color: Color(0xFFCBD5E1)),
                SizedBox(width: 12),
                Text(
                  "Grace Period",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(),
                BadgePill(text: "NOT TRIGGERED"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFF9BE7FF),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9BE7FF).withValues(alpha: 0.25),
                  blurRadius: 18,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "♡  Check-In (Heartbeat)",
                style: TextStyle(
                  color: Color(0xFF07111F),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String? rightText;
  final String? badge;

  const SectionTitle({
    super.key,
    required this.title,
    this.rightText,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        if (rightText != null)
          Text(
            rightText!,
            style: const TextStyle(
              color: Color(0xFF9BE7FF),
              fontWeight: FontWeight.w800,
            ),
          ),
        if (badge != null) BadgePill(text: badge!),
      ],
    );
  }
}

class BadgePill extends StatelessWidget {
  final String text;

  const BadgePill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final bool highlighted;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: highlighted
            ? const Color(0xFF1E293B).withValues(alpha: 0.75)
            : Colors.white.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlighted
              ? const Color(0xFF9BE7FF).withValues(alpha: 0.25)
              : Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: child,
    );
  }
}

class VaultXBottomNav extends StatelessWidget {
  const VaultXBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: const Color(0xFF07111F),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF9BE7FF)),
          Icon(Icons.group_outlined, color: Color(0xFFCBD5E1)),
          Icon(Icons.security_outlined, color: Color(0xFFCBD5E1)),
          Icon(Icons.settings_outlined, color: Color(0xFFCBD5E1)),
        ],
      ),
    );
  }
}
