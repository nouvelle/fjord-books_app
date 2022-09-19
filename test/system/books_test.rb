# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    # トップページにアクセスする
    visit root_url
    # email アドレスを入力する
    fill_in 'Eメール', with: 'alice@example.com'
    # パスワードを入力する
    fill_in 'パスワード', with: 'password'
    # ログインボタンをクリックする
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
    assert_text 'coffee'
    assert_text '美味しいコーヒーの淹れ方'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'タイトルテスト'
    fill_in 'メモ', with: 'メモ欄テスト'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'タイトルテスト'
    assert_text 'メモ欄テスト'
  end

  test 'updating a Book' do
    visit books_url
    assert_no_text 'tea'

    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: 'tea'
    fill_in 'メモ', with: '美味しい紅茶の淹れ方'
    click_on '更新する'

    assert_text '本が更新されました。'
    click_on '戻る'

    assert_selector 'h1', text: '本'
    assert_text 'tea'
    assert_text '美味しい紅茶の淹れ方'
  end

  test 'destroying a Book' do
    visit books_url

    assert_text 'coffee'
    assert_text '美味しいコーヒーの淹れ方'

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '本が削除されました。'
    assert_no_text 'coffee'
    assert_no_text '美味しいコーヒーの淹れ方'
  end

  test 'back link from book create page' do
    visit books_url
    click_on '新規作成'
    click_on '戻る'
    assert_selector 'h1', text: '本'
  end
end
