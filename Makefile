YR := 2021
CWS_YR := 2021
RUN_R = Rscript $< $(YR) $(CWS_YR)

.PHONY: testvars
testvars:
	Rscript utils/pkgs_utils.R $(YR) $(CWS_YR)

.PHONY: all
all: distro README.md

.PHONY: distro
distro: output_data/acs_nhoods_by_city_$(YR).rds website/5year$(YR)town_profile_expanded_CWS.csv

# writes website_meta, downloads reg_puma_list
utils/$(YR)_website_meta.rds utils/reg_puma_list.rds utils/indicator_headings.txt: scripts/00_make_meta.R
	$(RUN_R)
	
# writes acs_basic_2020_fetch_all
fetch_data/acs_basic_$(YR)_fetch_all.rds: scripts/01_fetch_acs_data.R utils/reg_puma_list.rds
	$(RUN_R)
	
# writes cws_basic_indicators_2021
output_data/cws_basic_indicators_$(CWS_YR).rds: scripts/02_calc_cws_data.R
	$(RUN_R)
	
# writes acs_town_basic_profile_2020.csv, acs_town_basic_profile_2020.rds, to_distro/town_acs_basic_distro_2020.rds
output_data/acs_town_basic_profile_$(YR).rds to_distro/town_acs_basic_distro_$(YR).csv: scripts/03_calc_acs_towns.R \
	fetch_data/acs_basic_$(YR)_fetch_all.rds \
	utils/indicator_headings.txt
	$(RUN_R)
	
# writes acs_nhoods_by_city_2020.rds, csv per city
output_data/acs_nhoods_by_city_$(YR).rds: scripts/04_calc_acs_nhoods.R \
	fetch_data/acs_basic_$(YR)_fetch_all.rds \
	utils/indicator_headings.txt
	$(RUN_R)

# writes 5year2020town_profile_expanded_CWS.csv
website/5year$(YR)town_profile_expanded_CWS.csv: scripts/05_assemble_for_distro.R \
	utils/$(YR)_website_meta.rds \
	output_data/acs_town_basic_profile_$(YR).rds \
	output_data/cws_basic_indicators_$(CWS_YR).rds \
	utils/indicator_headings.txt
	$(RUN_R)

scripts/*.R: utils/pkgs_utils.R

README.md: README.Rmd
	R -e "rmarkdown::render('README.Rmd', output_format = rmarkdown::github_document(html_preview = FALSE))"

.PHONY: clean
clean:
	rm -f output_data/* to_distro/* fetch_data/*
