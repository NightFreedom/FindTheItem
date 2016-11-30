class UsersController < ApplicationController
    before_action :authenticate_user!
    def show
        if params[:id].nil?
            @user=current_user
        else
            @user=User.find_by_id(params[:id]) 
        end
        @items=Item.all

    end
    def index
        @users=User.all
    end
    def make
        user=User.find(params[:id])
        user.update_attribute :admin, true
        redirect_to users_path
    end
    def convertToReadable(elapsed_time)
        case elapsed_time
        when 0 then 'just now'
        when 1 then 'second'
        when 2..59 then "#{elapsed_time.to_s} seconds"
        when 60..119 then 'a minute'
        when 120..3540 then "#{(elapsed_time/60).to_s} minutes"
        when 3541..7100 then 'an hour'
        when 7101..82800 then "#{((elapsed_time+99)/3600).to_s} hours"
        when 82801..172000 then "#{(elapsed_time/3600).to_s} hours"
        when 172001..518400 then "#{((elapsed_time+800)/(60*60*24)).to_i.to_s} days"
        when 518400..1036800 then 'a week'
        else "#{((time_elapsed+180000)/(60*60*24*7)).to_i.to_s} weeks"
        end
    end
    helper_method :convertToReadable
end
