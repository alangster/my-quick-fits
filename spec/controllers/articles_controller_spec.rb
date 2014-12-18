require 'rails_helper'

describe ArticlesController do 

	after(:all) do
		Article.destroy_all
		Category.destroy_all
		User.destroy_all
	end

	describe 'new' do
		it 'instantiates a new article' do
			get :new
			expect(assigns(:article)).to be_a(Article)
			expect(assigns(:article).id).to be_nil
		end
	end

	describe 'show' do

		context 'existing article' do
			it 'finds the requested article' do
				t_shirt = FactoryGirl.create(:category, :type_of => 'Top', :name => 'T-Shirt')
				article = FactoryGirl.create(:article, :category => t_shirt)
				get :show, id: article.id
				expect(assigns(:article)).to eq(article)
			end
		end

		context 'nonexistant article' do
			it 'redirects to profile' do
				user = FactoryGirl.create(:user)
				session[:user_id] = user.id
				get :show, id: 0
				expect(response).to redirect_to("/users/#{user.id}")
			end
		end

	end

	describe 'create' do

		before(:all) do
			@user = FactoryGirl.create(:user)
			@wardrobe = FactoryGirl.create(:wardrobe, :user => @user)
			@t_shirt = FactoryGirl.create(:category, :type_of => 'Top', :name => 'T-Shirt')
		end

		context 'valid article information' do

			context 'primary, secondary, and tertiary colors' do
				it 'saves article with all info' do
					session[:user_id] = @user.id
					article_attrs = {:category => @t_shirt.id, :primary => '30,40,50', :secondary => '90,100,80', :tertiary => '220,18,125'}
					post :create, article_attrs
					controller = double("ArticlesController")
					expect(controller).to receive(:article_color_data)
					# expect(assigns(:article).primary_color).to match(/\A[A-Z][a-z]+/)
					# expect(assigns(:article).primary_color_hex).to match(/\A#[a-f0-9]{6}/)
					# expect(assigns(:article).secondary_color).to match(/\A[A-Z][a-z]+/)
					# expect(assigns(:article).secondary_color_hex).to match(/\A#[a-f0-9]{6}/)
					# expect(assigns(:article).tertiary_color).to match(/\A[A-Z][a-z]+/)
					# expect(assigns(:article).tertiary_color_hex).to match(/\A#[a-f0-9]{6}/)
					# expect(flash[:notice]).to eq("T-Shirt added successfully!")
					# expect(response).to redirect_to("/users/#{@user.id}")
				end
			end

			context 'primary and secondary colors' do
				it 'saves article with tertiary nil' do
					session[:user_id] = @user.id
					article_attrs = {:category => @t_shirt.id, :primary => '30,40,50', :secondary => '90,100,80', :tertiary => ''}
					post :create, article_attrs
					expect(assigns(:article).primary_color).to match(/\A[A-Z][a-z]+/)
					expect(assigns(:article).primary_color_hex).to match(/\A#[a-f0-9]{6}/)
					expect(assigns(:article).secondary_color).to match(/\A[A-Z][a-z]+/)
					expect(assigns(:article).secondary_color_hex).to match(/\A#[a-f0-9]{6}/)
					expect(assigns(:article).tertiary_color).to be_nil
					expect(assigns(:article).tertiary_color_hex).to be_nil
					expect(flash[:notice]).to eq("T-Shirt added successfully!")
					expect(response).to redirect_to("/users/#{@user.id}")
				end
			end

			context 'only primary color' do
				it 'saves article with secondary and tertiary nil' do
					session[:user_id] = @user.id
					article_attrs = {:category => @t_shirt.id, :primary => '30,40,50', :secondary => '', :tertiary => ''}
					post :create, article_attrs
					expect(assigns(:article).primary_color).to match(/\A[A-Z][a-z]+/)
					expect(assigns(:article).primary_color_hex).to match(/\A#[a-f0-9]{6}/)
					expect(assigns(:article).secondary_color).to be_nil
					expect(assigns(:article).secondary_color_hex).to be_nil
					expect(assigns(:article).tertiary_color).to be_nil
					expect(assigns(:article).tertiary_color_hex).to be_nil
					expect(flash[:notice]).to eq("T-Shirt added successfully!")
					expect(response).to redirect_to("/users/#{@user.id}")
				end
			end

		end

		context 'invalid article information' do

			context 'no color information' do
				it 'does not create an article' do
					session[:user_id] = @user.id
					article_attrs = {:category => @t_shirt.id, :primary => '', :secondary => '', :tertiary => ''}
					post :create, article_attrs
					expect(assigns(:article).id).to be_nil
					expect(response).to render_template(:new)
				end
			end

			context 'no category specified' do
				it 'does not create an article' do
					session[:user_id] = @user.id
					article_attrs = {:category => @t_shirt.id, :primary => '', :secondary => '', :tertiary => ''}
					post :create, article_attrs
					expect(assigns(:article).id).to be_nil
					expect(response).to render_template(:new)
				end
			end

		end

	end

	describe 'destroy' do

		it 'removes article from database' do
			user = FactoryGirl.create(:user)
			wardrobe = FactoryGirl.create(:wardrobe, :user => user)
			t_shirt = FactoryGirl.create(:category, :type_of => 'Top', :name => 'T-Shirt')
			article = FactoryGirl.create(:article, :category => t_shirt)
			session[:user_id] = user.id 
			expect(Article.find_by(id: article.id)).not_to be_nil

			delete :destroy, id: article.id
			expect(Article.find_by(id: article.id)).to be_nil
			expect(response).to redirect_to("/wardrobes/#{wardrobe.id}")
		end
		
	end

end