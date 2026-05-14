-- Supabase setup for 불량 진주 이벤트 페이지
-- 1) 기존 테이블에 필요한 컬럼 추가
alter table contest_entries add column if not exists instagram_id text;
alter table contest_entries add column if not exists approved boolean default false;
alter table contest_entries alter column approved set default false;

-- 2) RLS 활성화
alter table contest_entries enable row level security;

-- 3) 기존 정책이 있다면 중복 방지를 위해 삭제 후 재생성
drop policy if exists "Anyone can submit contest entries" on contest_entries;
drop policy if exists "Anyone can view approved contest entries" on contest_entries;
drop policy if exists "Admin can view all contest entries" on contest_entries;
drop policy if exists "Admin can update contest entries" on contest_entries;

-- 4) 공개 페이지 권한
create policy "Anyone can submit contest entries"
on contest_entries for insert
to anon
with check (true);

create policy "Anyone can view approved contest entries"
on contest_entries for select
to anon
using (approved = true);

-- 5) 관리자 권한 - 관리자 이메일이 다르면 아래 이메일만 수정하세요.
create policy "Admin can view all contest entries"
on contest_entries for select
to authenticated
using ((auth.jwt() ->> 'email') = 'dynnn@bir.co.kr');

create policy "Admin can update contest entries"
on contest_entries for update
to authenticated
using ((auth.jwt() ->> 'email') = 'dynnn@bir.co.kr')
with check ((auth.jwt() ->> 'email') = 'dynnn@bir.co.kr');

-- 6) Storage 정책
drop policy if exists "Anyone can upload contest images" on storage.objects;
drop policy if exists "Anyone can read contest images" on storage.objects;

create policy "Anyone can upload contest images"
on storage.objects for insert
to anon
with check (bucket_id = 'contest-images');

create policy "Anyone can read contest images"
on storage.objects for select
to anon
using (bucket_id = 'contest-images');
