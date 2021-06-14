RSpec.describe SearchProducts do
  let!(:product_1) { create :product, price: 10 }
  let!(:product_2) { create :product, price: 20 }
  let!(:product_3) { create :product, price: 30 }
  let(:products) { Product.all }

  subject { described_class.new(products: products).call(search_params) }

  context "with empty params" do
    let(:search_params) { {} }

    it "sorts" do
      expect(subject.size).to eq 3
      expect(subject.ids).to eq [product_3.id, product_2.id, product_1.id]
    end

    it "paginates" do
      expect(subject.total_pages).to eq 1
      expect(subject.total_count).to eq 3
      expect(subject.current_page).to eq 1
    end
  end

  context "with search price" do
    let(:search_params) { {price_from: 20} }
    it do
      expect(subject.size).to eq 2
    end
  end

  # TODO: category, tile, something ...
end
