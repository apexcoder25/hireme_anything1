import 'package:flutter/material.dart';

class AuthProgressIndicator extends StatelessWidget {
   final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const AuthProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.stepLabels = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep - 1;
              final isCurrent = index == currentStep - 1;
              // final isUpcoming = index > currentStep - 1;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: isCompleted || isCurrent
                              ? const Color(0xff0e53ce)
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                    if (index < totalSteps - 1) const SizedBox(width: 8),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep - 1;
              final isCurrent = index == currentStep - 1;

              return Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted || isCurrent
                            ? const Color(0xff0e53ce)
                            : Colors.grey.shade300,
                        border: Border.all(
                          color: isCompleted || isCurrent
                              ? const Color(0xff0e53ce)
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              )
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isCurrent ? Colors.white : Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                      ),
                    ),
                    if (stepLabels.isNotEmpty && stepLabels.length > index) ...[
                      const SizedBox(height: 8),
                      Text(
                        stepLabels[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isCompleted || isCurrent
                              ? const Color(0xff0e53ce)
                              : Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
