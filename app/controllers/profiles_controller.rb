class ProfilesController < ApplicationController
   def new
       # display form where a user can fill out their own profile
       @user = User.find( params[:user_id] )
       @profile = Profile.new
   end
   
   def create
       @user = User.find(params[:user_id])
       @profile = @user.build_profile( profile_params ) # build profile based on whitelisted data passed from the new page 
       if @profile.save
           flash[:success] = "Profile Updated"
           redirect_to user_path( params[:user_id] )
       else
           render action: :new
       end
   end
   
   def edit
       @user = User.find( params[:user_id] )
       @profile = @user.profile
   end
   
   private
   def profile_params # whitelist input data from 'new' page submit action
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
   end
end