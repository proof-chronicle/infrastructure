.PHONY: add-local-hosts
add-local-hosts:
	./scripts/add-hosts.sh 127.0.0.1 proofchronicle.local

.PHONY: init-venv
init-venv:
	python3 -m venv diagrams/venv
	. diagrams/venv/bin/activate && pip install --upgrade pip && pip install -r ./diagrams/requirements.txt

.PHONY: render-diagrams
render-diagrams: init-venv
	. diagrams/venv/bin/activate && python diagrams/main.py