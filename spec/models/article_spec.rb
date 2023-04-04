require 'rails_helper'

RSpec.describe Article, type: :system do

  scenario 'empty title and body' do

    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit new_article_path
    click_button 'Create Article'

    # The page should show error message 'Title can't be blank'
    expect(page).to have_content("Title can't be blank")

    # No bookmark record is created
    expect(Article.count).to eq(0)
  end
  
  # happy path scenario block
  scenario 'valid title and body' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit new_article_path
    # fill in text fields with specified string
    fill_in 'article[title]', with: 'RubyYagi'
    fill_in 'article[body]', with: 'ghbjrubyyagi'
    click_button 'Create Article'
    
    # The page should show success message
    expect(page).to have_content("RubyYagi")

    # 1 new bookmark record is created
    expect(Article.count).to eq(1)
    
    # Optionally, you can check the latest record data
    expect(Article.last.title).to eq('RubyYagi')
  end
   # this will create a 'article' method, before each scenario is ran

   scenario 'update empty title and body' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit articles_path
    click_link 'New Article'
    fill_in 'article[title]', with: 'Article'
    fill_in 'article[body]', with: 'Description'
    click_button 'Create Article'
    click_link 'Edit'
    # fill in text fields with specified string
    fill_in 'article[title]', with: ''
    fill_in 'article[body]', with: ''
    click_button 'Update Article'
    
    # The page should show success message
    expect(page).to have_content("Title can't be blank")

   # The article title should be unchanged
   expect(Article.last.title).to eq("Article")
  end
  
  scenario 'update title and body' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit articles_path
    click_link 'New Article'
    fill_in 'article[title]', with: 'Article'
    fill_in 'article[body]', with: 'Description'
    click_button 'Create Article'
    click_link 'Edit'
    # fill in text fields with specified string
    fill_in 'article[title]', with: 'Article2'
    fill_in 'article[body]', with: 'DescriptionArticle2'
    click_button 'Update Article'
    
    # The page should show success message
    expect(page).to have_content("Article2")

    expect(Article.last.title).to eq("Article2")
    expect(Article.last.body).to eq("DescriptionArticle2")
  end

end
