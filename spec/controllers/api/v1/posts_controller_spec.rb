# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe 'GET index without pagy' do
    let(:post_category) { create(:post_category) }
    let!(:post) { create(:post, :with_image_from_file, post_category_id: post_category.id) }

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'returns all the post' do
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(1)
    end
  end

  describe 'GET Index with Pagy' do
    let(:post_category) { create(:post_category) }
    let!(:post_lists) { create_list(:post, 4, :with_image_from_file, post_category_id: post_category.id) }
    it 'return first page' do

      get :index, params: { size: 1, page: 1 }
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to_not be_nil
      expect(parsed_response['data'][0]['id']).to eq post_lists[3].id.to_s
      expect(parsed_response['links']['preview_page_url']).to be_nil
    end

    it 'return last page' do
      get :index, params: { size: 2, page: 2 }
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response['data']).to_not be_nil
      expect(parsed_response['data'][0]['id']).to eq post_lists[1].id.to_s
      expect(parsed_response['data'][1]['id']).to eq post_lists[0].id.to_s
      expect(parsed_response['links']['next_page_url']).to be_nil
    end
  end

  describe "GET 'show' " do
    let(:post_category) { create(:post_category) }
    let!(:post) { create(:post, :with_image_from_file, post_category_id: post_category.id) }

    it 'returns a successful 200 response' do
      get :show, params: { id: post.id }
      expect(response.status).to eq(200)
    end

    it 'returns data of an single post' do
      get :show, params: { id: post.id }, format: :json
      expect(response.status).to eq(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']).to_not be_nil
    end

    # it 'returns an error if the post does not exist' do
    #   get :show, params: { id: 10 }, format: :json
    #   parsed_response = JSON.parse(response.body)
    #   expect(parsed_response['error']).to eq("post does not exist")
    #   expect(response).to be_not_found
    #   expect(response).to raise_error ActiveRecord::RecordNotFound
    # end
  end

  describe '#related posts' do
    let(:post_category) { create(:post_category) }
    let!(:post_list) { create_list(:post, 10, :with_image_from_file, post_category_id: post_category.id) }
    let(:num_limited) { 3 }
    let(:param) { post_list.first.id }

    before { get :related_posts, params: { id: param }, format: :json }

    context 'oldest posts' do
      let(:param) { post_list.first.id }

      it 'current post is first post' do
        parsed_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_response['data']).to_not be_nil
        expect(parsed_response['data'].length).to eq num_limited
        expect(parsed_response['data'][0]['id']).to eq post_list[3].id.to_s
        expect(parsed_response['data'][1]['id']).to eq post_list[2].id.to_s
        expect(parsed_response['data'][2]['id']).to eq post_list[1].id.to_s
      end
    end

    context 'latest_posts posts' do
      let(:param) { post_list.last.id }

      it 'current post is last post' do
        parsed_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_response['data']).to_not be_nil
        expect(parsed_response['data'].length).to eq num_limited
        expect(parsed_response['data'][0]['id']).to eq post_list[8].id.to_s
        expect(parsed_response['data'][1]['id']).to eq post_list[7].id.to_s
        expect(parsed_response['data'][2]['id']).to eq post_list[6].id.to_s
      end
    end

    context 'latest_posts_length == num_limited' do
      let(:current_post_id) { ((post_list.first.id + post_list.last.id) / 2) }
      let(:param) { current_post_id }

      it 'current post is not last post and not first post' do
        parsed_response = JSON.parse(response.body)
        current_post_index = post_list.index { |post| post.id == current_post_id }

        expect(response.status).to eq(200)
        expect(parsed_response['data']).to_not be_nil
        expect(parsed_response['data'].length).to eq num_limited
        expect(parsed_response['data'][0]['id']).to eq post_list[current_post_index + 2].id.to_s
        expect(parsed_response['data'][1]['id']).to eq post_list[current_post_index + 1].id.to_s
        expect(parsed_response['data'][2]['id']).to eq post_list[current_post_index - 1].id.to_s
      end
    end

    context 'current post is post_list[length - 3]' do
      let(:param) { post_list[post_list.length - 3] }

      it 'current post is not last post and not first post' do
        parsed_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_response['data']).to_not be_nil
        expect(parsed_response['data'].length).to eq num_limited
        expect(parsed_response['data'][0]['id']).to eq post_list.last.id.to_s
        expect(parsed_response['data'][1]['id']).to eq post_list[8].id.to_s
        expect(parsed_response['data'][2]['id']).to eq post_list[6].id.to_s
      end
    end
  end

  describe '#related posts (total post <= num_limit)' do
    let(:post_category) { create(:post_category) }
    let!(:post_list) { create_list(:post, 3, :with_image_from_file, post_category_id: post_category.id) }
    let(:param) { ((Post.first.id + Post.first.id) / 2) + 1 }
    before { get :related_posts, params: { id: param }, format: :json }

    it 'latest_posts_length + oldest_posts_length <= num_limited' do
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed_response['data']).to_not be_nil
      expect(parsed_response['data'].length).to eq 2
      expect(parsed_response['data'][0]['id']).to eq post_list[2].id.to_s
      expect(parsed_response['data'][1]['id']).to eq post_list[0].id.to_s
    end
  end
end
