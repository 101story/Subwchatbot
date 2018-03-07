require 'msgmaker'
require 'parser'

class KakaoController < ApplicationController

  @@keyboard = Msgmaker::Keyboard.new
  @@message = Msgmaker::Message.new

  def keyboard
    #render json: @@keyboard.getBtnKey(["고양이", "영화", "서브웨이"])
    render json: @@keyboard.getTextKey
  end


  def message
    basic_keyboard = @@keyboard.getBtnKey(["고양이", "영화", "서브웨이"])
    user_msg = params[:content]

    if user_msg == "고양이"
      parse = Parser::Animal.new
      msg = @@message.getPicMessage("냐옹냐옹", parse.cat)
    elsif user_msg == "강아지"
      parse = Parser::Animal.new
      msg = @@message.getPicMessage("멍멍", parse.dog)
    else
      url = '서브웨이 홈페이지 http://m.subway.co.kr/sandwichList'
      msg = @@message.getMessage(url)
    end

    result = {
      message: msg
    }

    render json: result
  end


  def friend_add
    User.create(user_key: params[:user_key], chat_room:0)
    render nothing: true
  end

  def friend_del
    user = User.find_by(user_key: params[:user_key])
    user.destory
    render nothing: true
  end

  def chat_room
    user = User.find_by(user_key: params[:user_key])
    user.plus
    user.save
    render nothing: true
  end

end
