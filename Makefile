.PHONY: data db analysis test all

data:
	python scripts/generate_synthetic_data.py

db:
	python scripts/build_database.py

analysis:
	python scripts/run_analysis.py

sql_reports:
	python scripts/run_sql_reports.py

test:
	python -m pytest tests

all: data db analysis sql_reports test
