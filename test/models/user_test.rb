# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#following?: ユーザをフォローしていたら true, していなければ false を返す' do
    # alice と bob のアカウントを作成
    alice = users(:alice)
    bob = users(:bob)

    # 最初は誰もフォローしていない
    assert_not alice.following?(bob)
    # alice は bob をフォロー
    alice.follow(bob)
    # フォロー後、フォローしていることをチェック
    assert alice.following?(bob)
    # フォローされている人はフォローはしていない
    assert_not bob.following?(alice)
  end

  test '#followed_by?: ユーザにフォローされていたら true, されていなければ false を返す' do
    # alice と bob のアカウントを作成
    alice = users(:alice)
    bob = users(:bob)

    # 最初は誰からもフォローされていない
    assert_not alice.followed_by?(bob)
    # bob が alice をフォロー
    bob.follow(alice)
    # alice が bob にフォローされていることをチェック
    assert alice.followed_by?(bob)
    # bob は alice にフォローされていないことをチェック
    assert_not bob.followed_by?(alice)
  end

  test '#follow: ユーザをフォローしていたら true, していなければ false を返す' do
    # alice と bob のアカウントを作成
    alice = users(:alice)
    bob = users(:bob)

    # 最初は誰もフォローしていない
    assert_not alice.following?(bob)
    # alice は bob をフォロー
    alice.follow(bob)
    # フォロー後、フォローしていることをチェック
    assert alice.following?(bob)
  end

  test '#unfollow: ユーザをアンフォローしたら true, できなければ false を返す' do
    # alice と bob のアカウントを作成
    alice = users(:alice)
    bob = users(:bob)
    
    # 最初は誰もアンフォローできない
    assert_not alice.unfollow(bob)
    # alice は bob をフォロー
    alice.follow(bob)
    # フォロー後、フォローしていることをチェック
    assert alice.following?(bob)
    # alice は bob をアンフォローできる
    assert alice.unfollow(bob)
    # alice は bob を既にアンフォロー済みなので、アンフォローできない
    assert_not alice.following?(bob)
  end

  test '#name_or_email: name か email があれば true, なければ false を返す' do
    # alice のアカウントを作成
    alice = User.new(email: 'alice@example.com', name: '')

    # name がなくても email があれば email を返す
    assert_equal 'alice@example.com', alice.name_or_email
    
    # name を設定
    alice.name = 'alice'

    # name があれば name を返す
    assert_equal 'alice', alice.name_or_email
  end



end
