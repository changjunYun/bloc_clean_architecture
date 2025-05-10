import 'package:bloc_clean_architecture/core/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable{
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
  });
  const User.empty()
      : this(
    id: "1",
    createdAt: '_empty.createdAt',
    name: '_empty.name',

  );
  final String id;
  final String createdAt;
  final String name;

  // id만 같으면 같은 사용자로 본다
  @override
  List<Object?> get props => [id];
}
/***
    ✅ 왜 이렇게 할까?

    1️⃣ 불필요한 상태 변경 방지

    만약 props에 name, avatar까지 넣으면 이름이나 아바타만 바뀌어도
    “다른 객체”로 인식 → 상태 변경으로 처리 → 리빌드 발생

    그러나 사실상 사용자 id가 같으면 같은 사용자로 봐도 되므로
    굳이 그걸로 리빌드를 발생시킬 필요가 없음 → 성능 최적화

    2️⃣ 업데이트 가능한 속성과 식별 속성 분리
    •	id → 절대 변하지 않는 고유 값 → props에 포함 → 비교 대상
    •	name, avatar → 언제든 바뀔 수 있는 값 → props에서 제외 → 비교 대상 아님

    이렇게 하면 진짜 중요한 변경만 상태 변경으로 인식하게 된다.
 ***/
