all:judged judge_client make_sim
judge_client:judge_client.c
	gcc -Wall -c judge_client.c
	gcc -Wall -o judge_client judge_client.o -lmysqlclient
judged:judged.c
	gcc -Wall -c judged.c
	gcc -Wall -o judged judged.o -lmysqlclient
make_sim:
	make -C sim
install:judged judge_client
	cp -f judged /usr/bin/judged
	cp -f judge_client /usr/bin/judge_client
	cp -u java0.policy /home/judge/etc/java0.policy
	cp -u judge.conf /home/judge/etc/judge.conf
	cp judged /etc/init.d/judged
	chmod +x /etc/init.d/judged
	ln -f -s /etc/init.d/judged /etc/rc3.d/S93judged
	ln -f -s /etc/init.d/judged /etc/rc2.d/S93judged
	make -C sim install
	cp sim.sh /usr/bin/sim.sh
clean:
	rm -f judged.o judged judge_client.o judge_client
	make -C sim clean
