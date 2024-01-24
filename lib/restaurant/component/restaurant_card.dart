import 'package:flutter/material.dart';
import 'package:inflearn_code_factory/common/const/colors.dart';

class RestaurantCard extends StatelessWidget {
  // 사진
  final Widget image;
  // 레스토랑 이름
  final String name;
  // 태그
  final List<String> tags;
  // 평점 개수
  final int ratingCount;
  // 배송 걸리는 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;
  // 평균 별점
  final double ratings;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ClipRRect: 이미지 테두리 둥글게 하기 위함
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: image,
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              // join: 배열을 문자열로 합치기
              tags.join(' ∙ '),

              style: const TextStyle(
                  color: BODY_TEXT_COLOR, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                _IconText(icon: Icons.star, label: ratings.toString()),
                renderDot(),
                _IconText(icon: Icons.receipt, label: ratingCount.toString()),
                renderDot(),
                _IconText(
                    icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
                renderDot(),
                _IconText(
                  icon: Icons.monetization_on,
                  label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Widget renderDot() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Text('∙'),
  );
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
