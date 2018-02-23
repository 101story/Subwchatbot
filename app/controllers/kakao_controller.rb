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
    # basic_keyboard = @@keyboard.getBtnKey(["고양이", "영화", "서브웨이"])
    user_msg = params[:content]
 
    if user_msg == "고양이"
      parse = Parser::Animal.new
      msg = @@message.getPicMessage("냐옹냐옹", parse.cat)
    elsif user_msg == "영화"
      parse = Parser::Movie.new
      msg = @@message.getMessage(parse.naver)
    else
      url = 'http://mblogthumb2.phinf.naver.net/MjAxNzA0MTBfMjg0/MDAxNDkxODMzMDcxNDIy.yKTvXOPhi1L5uu0LQhdIyuiMMz-nC0Wjw7nCs6PjQ6og.w7uA6g6gD-2TgJTyDjHuOvh_IRWqcbf5_q5qSzBVp4wg.JPEG.lastkycool/P1090483-0.jpg?type=w800'
      msg = @@message.getPicMessage("추천", url)
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