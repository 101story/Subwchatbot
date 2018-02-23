# Kakaotalk with ruby 

## HEROKU Deploy

#### 변경전
#gem 'sqlite3'
#### 변경후
gem 'sqlite3', :group => :development
gem 'pg', :group => :production
gem 'rails_12factor', :group => :production
그리고 /config/database.yml파일도 수정을 해주세요

#### 변경전
#production:
#<<: *default
#database: db/production.sqlite3

### 변경후  
production:
  <<: *default
  adapter: postgresql
  encoding: unicode
다음의 순서대로 진행하면 됩니다.

* git을 생성
git init
git add .
git commit -m "kakao_bot"

*  헤로쿠에 로그인해서 앱을 만듬
heroku login
heroku create

*  우리의 프로젝트를 헤로쿠에 디플로
git push heroku master