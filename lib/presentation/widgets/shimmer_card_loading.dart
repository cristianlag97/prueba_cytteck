part of 'widgets.dart';

class ShimmerCardLoading extends StatelessWidget {
  const ShimmerCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: size16,
            vertical: size8,
          ),
          child: Shimmer.fromColors(
            baseColor: CyttekColor.shimmer,
            highlightColor: CyttekColor.shimmerLight,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size12),
              ),
              child: SizedBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(size16),
                  child: Row(
                    children: [
                      Container(
                        width: size80,
                        height: size80,
                        decoration: BoxDecoration(
                          color: CyttekColor.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: size16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size20,
                              width: double.infinity,
                              color: CyttekColor.whiteColor,
                            ),
                            const SizedBox(height: size8),
                            Container(
                              height: size16,
                              width: 150,
                              color: CyttekColor.whiteColor,
                            ),
                            const Spacer(),
                            Container(
                              height: size12,
                              width: 100,
                              color: CyttekColor.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
