require "caesar"

describe "#caesar_cipher" do
    context "when empty string" do

        it "returns an empty string" do
            expect(caesar_cipher("", 0)).to eql("")
        end

        it "returns 'Bmfy f xywnsl!' for 'What a string!' with 5" do
            expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
        end

        it "doesn't shift anything that isn't a letter" do
            expect(caesar_cipher("0123456789{}:.,)(*&^%$#@!``", 3)).to eql("0123456789{}:.,)(*&^%$#@!``")
        end

        it "Works with negative shifts" do
            expect(caesar_cipher("ABCDEFGhijklmnop", -1)).to eql("ZABCDEFghijklmno")   
        end
    end
end
