# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#following?: ユーザをフォローしていたら true, していなければ false を返す' do
    # me と you のアカウントを作成
    me = User.create!(email: 'me@email.com', password: 'password')
    you = User.create!(email: 'you@email.com', password: 'password')

    # 最初は誰もフォローしていない
    assert_not me.following?(you)
    # me は you をフォロー
    me.follow(you)
    # フォロー後、フォローしていることをチェック
    assert me.following?(you)
    # フォローされている人はフォローはしていない
    assert_not you.following?(me)
  end

  test '#followed_by?: ユーザにフォローされていたら true, されていなければ false を返す' do
    # me と you のアカウントを作成
    me = User.create!(email: 'me@email.com', password: 'password')
    you = User.create!(email: 'you@email.com', password: 'password')

    # 最初は誰からもフォローされていない
    assert_not me.followed_by?(you)
    # you が me をフォロー
    you.follow(me)
    # me が you にフォローされていることをチェック
    assert me.followed_by?(you)
    # you は me にフォローされていないことをチェック
    assert_not you.followed_by?(me)
  end

  test '#follow: ユーザをフォローしていたら true, していなければ false を返す' do
    # me と you のアカウントを作成
    me = User.create!(email: 'me@email.com', password: 'password')
    you = User.create!(email: 'you@email.com', password: 'password')

    # 最初は誰もフォローしていない
    assert_not me.following?(you)
    # me は you をフォロー
    me.follow(you)
    # フォロー後、フォローしていることをチェック
    assert me.following?(you)
  end

  test '#unfollow: ユーザをアンフォローしたら true, できなければ false を返す' do
    # me と you のアカウントを作成
    me = User.create!(email: 'me@email.com', password: 'password')
    you = User.create!(email: 'you@email.com', password: 'password')
    
    # 最初は誰もアンフォローできない
    assert_not me.unfollow(you)
    # me は you をフォロー
    me.follow(you)
    # フォロー後、フォローしていることをチェック
    assert me.following?(you)
    # me は you をアンフォローできる
    assert me.unfollow(you)
    # me は you を既にアンフォロー済みなので、アンフォローできない
    assert_not me.following?(you)
  end

  test '#name_or_email: name か email があれば true, なければ false を返す' do
    # me のアカウントを作成
    me = User.new(email: 'me@email.com', name: '')

    # name がなくても email があれば email を返す
    assert_equal 'me@email.com', me.name_or_email
    
    # name を設定
    me.name = 'me'

    # name があれば name を返す
    assert_equal 'me', me.name_or_email
  end



end
