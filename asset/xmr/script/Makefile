# Makefile

scripts = monero-cli.sh monero-wallet.sh monero-walletd.sh monerod.sh monero-wallet-cli.sh runas.sh
user = xmr

ifeq ($(shell uname), Linux)
	instparam := -v -T
else
	instparam := -v
endif

all : mainnet

mainnet :
	@mkdir -p /tmp/$(user)
	@for file in $(scripts); do sed 's/testnet=1/testnet=0/' $$file > /tmp/$(user)/$$file; done
	@for file in $(scripts); do sudo install $(instparam) /tmp/$(user)/$$file $$HOME/$(user)/$$file; done
	@cd $$HOME/$(user); sudo chmod a+x $(scripts); sudo chown $(user):$(user) $(scripts)

testnet :
	@mkdir -p /tmp/$(user)
	@for file in $(scripts); do sed 's/testnet=0/testnet=1/' $$file > /tmp/$(user)/$$file; done
	@for file in $(scripts); do sudo install $(instparam) /tmp/$(user)/$$file $$HOME/$(user)/$$file; done
	@cd $$HOME/$(user); sudo chmod a+x $(scripts); sudo chown $(user):$(user) $(scripts)
