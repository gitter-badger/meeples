require 'spec_helper'

describe 'Managing Users' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'listing' do

    let(:path) { admin_users_path }

    describe 'permissions' do

      it { should_not allow_access.to :guest }
      it { should_not allow_access.to :user }
      it { should     allow_access.to :admin }

    end

    context 'when allowed' do

      let(:other_users) { User.where 'id != ?', admin.id }

      before do
        FactoryGirl.create_list :user, 3
        login_as admin
        visit path
      end

      it { should have_css "a[href='#{ new_admin_user_path }']" }

      it 'links to edit each user' do
        User.all.map do |user|
          should have_css "a[href='#{ edit_admin_user_path user }']"
        end
      end

      it 'links to delete each user' do
        other_users.all.map do |user|
          should have_css "a[href='#{ admin_user_path user }'][data-method='delete']"
        end
      end

      context 'unlocked accounts' do

        before do
          other_users.last.lock_access!
          visit path
        end

        it 'does not link to lock the current user' do
          should_not have_css "a[href='#{ lock_admin_user_path user }']"
        end

        it 'does not link to unlock each user' do
          User.access_unlocked.map do |user|
            should_not have_css "a[href='#{ unlock_admin_user_path user }']"
          end
        end

        it 'links to lock each user' do
          other_users.access_unlocked.map do |user|
            should have_css "a[href='#{ lock_admin_user_path user }']"
          end
        end

      end

      context 'locked accounts' do

        before do
          other_users.last.lock_access!
          visit path
        end

        it 'does not link to lock each user' do
          User.access_locked.map do |user|
            should_not have_css "a[href='#{ lock_admin_user_path user }']"
          end
        end

        it 'links to unlock each user' do
          User.access_locked.map do |user|
            should have_css "a[href='#{ unlock_admin_user_path user }']"
          end
        end

      end

    end

  end

  describe 'creating' do

    let(:path) { new_admin_user_path }

    describe 'permissions' do

      it { should_not allow_access.to :guest }
      it { should_not allow_access.to :user }
      it { should     allow_access.to :admin }

    end

    context 'when allowed' do

      before do
        login_as admin
        visit path
      end

      it 'creates a new user' do
        # invalid data
        click_button 'Create User'

        should have_content 'User was not successfully created'
        should have_css '.input.error'

        # valid data
        fill_in_fields :user, email: 'picard@enterprise.com', password: 'password'

        check 'Admin'

        click_button 'Create User'
        should have_content 'User was successfully created'
      end

    end

  end

  describe 'editing' do

    let(:path) { edit_admin_user_path user }

    describe 'permissions' do

      it { should_not allow_access.to :guest }
      it { should_not allow_access.to :user }
      it { should     allow_access.to :admin }

    end

    context 'when allowed' do

      before do
        login_as admin
        visit path
      end

      it 'updates the user' do
        # invalid data
        fill_in_fields :user, email: ''

        click_button 'Update User'
        should have_content 'User was not successfully updated'

        # valid data
        fill_in_fields :user, email: user.email, password: 'drowssap'

        check 'Admin'

        click_button 'Update User'
        should have_content 'User was successfully updated'
      end

    end

  end

  describe 'destroying' do

    let(:path) { admin_users_path }

    before do
      user
      login_as admin
      visit path
    end

    it 'prompts for confirmation' do
      href    = "href='#{ admin_user_path user }'"
      method  = 'data-method="delete"'
      confirm = 'data-confirm="Are you sure you want to delete this?"'

      should have_css "a[#{ href }][#{ method }][#{ confirm }]"
    end

    it 'deletes the user' do
      find("a[href='#{ admin_user_path user }'][data-method='delete']").click

      ->{ user.reload }.should raise_exception ActiveRecord::RecordNotFound
    end

  end

end
