class UserController < ApplicationController
    skip_before_action :verify_authenticity_token

     # get
     def index

        # find by id
        if params[:id]
            render json: User.find(params[:id])
        
        # find by name
        elsif params[:name]
            render json: User.where(name: params[:name])
        
        # find by email
        elsif params[:email]
            render json: User.where(email: params[:email])

        # find all
        else 
            render json: User.all()
        end
    end

    #search mail and check password
    def validate
        res = {
            'status' => "failure",
            'log' =>  "none",
            'users' => []
        }
        user = User.find_by(email: params[:email])
        # puts user
        if user == nil
            render json: "user not found"
        else
            render json: user.authenticate(params[:password])
        end
    end

    #put
    def update 
        user = User.find_by(email: params[:email])
        puts "here" 
        puts user
        if !user
            render json: "invalid mail"
            return
        end
        res = user.authenticate(params[:old_password])
        if !res
            render json: "invalid password"
        else
            user.password = params[:new_password]
            user.save();
        
            render json: user
        end

    end 

    #post 
    def create 
        res = User.create(name: params[:name], email: params[:email], password: params[:password], phone: params[:phone]);
        render json: res;
    end

    # pagination
    def user_page 
        # puts "here"
        size = params[:page_size] ? params[:page_size].to_i : 0;
        ind = params[:page_index] ? (params[:page_index].to_i - 1)*size : 0;
        res = User.limit(size).offset(ind);
        render json: res;
    end
end
