#!/usr/bin/env bash
YR=2021
# metadata for other projects
gh release upload dist "output_data/acs_town_basic_profile_${YR}.rds" --clobber
