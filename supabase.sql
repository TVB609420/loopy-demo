-- LOOPY LIVE DEMO — Supabase setup
-- Run the whole script in Supabase SQL Editor.

create table if not exists public.loopy_state (
  id text primary key,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.loopy_state enable row level security;

grant usage on schema public to anon, authenticated;
grant select, insert, update on public.loopy_state to anon, authenticated;

drop policy if exists "loopy demo read" on public.loopy_state;
drop policy if exists "loopy demo insert" on public.loopy_state;
drop policy if exists "loopy demo update" on public.loopy_state;

create policy "loopy demo read"
on public.loopy_state
for select
to anon, authenticated
using (true);

create policy "loopy demo insert"
on public.loopy_state
for insert
to anon, authenticated
with check (true);

create policy "loopy demo update"
on public.loopy_state
for update
to anon, authenticated
using (true)
with check (true);

do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname='supabase_realtime'
      and schemaname='public'
      and tablename='loopy_state'
  ) then
    alter publication supabase_realtime add table public.loopy_state;
  end if;
end $$;

-- Verify Realtime membership:
select *
from pg_publication_tables
where pubname='supabase_realtime'
  and schemaname='public'
  and tablename='loopy_state';
