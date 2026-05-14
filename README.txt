# 불량 진주 이벤트 페이지 배포 파일

GitHub Pages에 올릴 파일입니다.

## 포함 파일
- index.html: 공개 이벤트 페이지
- admin.html: 관리자 페이지
- config.js: Supabase 공개 URL / publishable key
- assets/pdfs: 도안 PDF 3개
- assets/images: 표지, 카드뉴스, 활용 방법 이미지
- supabase-setup.sql: Supabase 설정용 SQL

## 공개 전 필수 체크
1. Supabase publishable key 재발급 후 config.js에 새 키 반영
2. service_role key / DB password / 관리자 비밀번호가 repo에 없는지 확인
3. supabase-setup.sql 실행
4. 관리자 계정 생성: dynnn@bir.co.kr
5. Storage bucket contest-images 설정 확인: public ON, 파일 10MB 제한, MIME image/png,image/jpeg,image/webp
6. 공개 페이지에서 테스트 응모 1건 제출
7. admin.html 로그인 후 승인/CSV 다운로드 테스트
8. 친구들 작품 구경하기에 개인정보가 노출되지 않는지 확인
