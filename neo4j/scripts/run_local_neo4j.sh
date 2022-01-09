#!/usr/bin/env bash

# Script entrypoint.
function main() {
  setup_env_vars
  validate_prerequisites
  parse_and_execute_command "$@"
}

# Set up shell environment variables.
function setup_env_vars() {
  root_dir=$(eval git rev-parse --show-toplevel)
  neo4j_dir="${root_dir}/neo4j"

  docker_container_name="local-neo4j"
  neo4j_login="neo4j"
  neo4j_password="pass"
}

# Parse CLI arguments and execute an appropriate command.
function parse_and_execute_command() {
  case "$1" in
  start)
    start_database
    ;;
  stop)
    stop_database
    ;;
  cypher_shell)
    setup_neo4j_import_dir
    cypher_shell
    ;;
  help)
    display_help
    ;;
  *)
    echo "No command specified, displaying help"
    display_help
    ;;
  esac
}

# Start local Docker Neo4j database.
function start_database() {
  database_container_status="$(get_database_container_status)"

  if [[ "$database_container_status" == "running" ]]; then
    echo "Local Docker Neo4j database is already running. \xE2\x9C\x94"
  elif [ "$database_container_status" == "exited" ]; then
    database_container_id="$(get_database_container_id)"
    docker start "$database_container_id"
    echo "Local Docker Neo4j database was stopped and has been re-started. \xE2\x9C\x94"
  else
    docker run \
        --name "$docker_container_name" \
        -p "7474:7474" \
        -p "7687:7687" \
        -d \
        -v "${neo4j_dir}/.db/data:/data" \
        -v "${neo4j_dir}/.db/logs:/logs" \
        -v "${neo4j_dir}/.db/import:/var/lib/neo4j/import" \
        -v "${neo4j_dir}/.db/plugins:/plugins" \
        --env "NEO4J_apoc_export_file_enabled=true" \
        --env "NEO4J_apoc_import_file_enabled=true" \
        --env "NEO4J_apoc_import_file_use__neo4j__config=true" \
        --env "NEO4JLABS_PLUGINS=[\"apoc\"]" \
        --env "NEO4J_AUTH=${neo4j_login}/${neo4j_password}" \
        "neo4j:latest"

    echo "Local Docker Neo4j database has been started. \xE2\x9C\x94"
  fi
}

# Copy Cypher files from "code" directory to Neo4j "import" directory so they are accessible in Cypher shell.
function setup_neo4j_import_dir() {
  neo4j_volume_import_dir="$neo4j_dir/.db/import"

  # Recreate import directory completely.
  rm -rf "$neo4j_volume_import_dir"
  mkdir -p "$neo4j_volume_import_dir"

  cp -R "$neo4j_dir/code" "$neo4j_volume_import_dir"
}

# Stop local Docker Neo4j database.
function stop_database() {
  database_container_status="$(get_database_container_status)"

  if [[ "$database_container_status" == "running" ]]; then
    database_container_id="$(get_database_container_id)"
    docker stop "$database_container_id"
    echo "Local Docker Neo4j database has been stopped. \xE2\x9C\x94"
  else
    echo "Local Docker Neo4j database is already not running. \xE2\x9C\x94"
  fi
}

# Open Cypher shell in local Docker Neo4j database.
function cypher_shell() {
  database_container_status="$(get_database_container_status)"
  if [[ "$database_container_status" != "running" ]]; then
    echo "Local Docker Neo4j database is not running. \xE2\x9C\x98"
    exit 1
  fi

  database_container_id="$(get_database_container_id)"
  docker exec \
    -it \
    "$docker_container_name" \
    "cypher-shell" \
    -u "$neo4j_login" \
    -p "$neo4j_password"
}

# Get local Neo4j database Docker container ID.
function get_database_container_id() {
  docker_container_id=$(docker container inspect -f '{{.Id}}' "$docker_container_name" 2>/dev/null)

  echo "$docker_container_id"
}

# Get local Neo4j database Docker container status.
function get_database_container_status() {
  docker_container_id=$(docker container inspect -f '{{.State.Status}}' "$docker_container_name" 2>/dev/null)

  echo "$docker_container_id"
}

# Validate script prerequisites.
function validate_prerequisites() {
  docker -v >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "'docker' is not installed or not runnable without sudo. \xE2\x9C\x98"
  else
    echo "'docker' is installed. \xE2\x9C\x94"
  fi
}

# Display CLI help.
function display_help() {
  echo "======================================"
  echo "   Neo4j Local Runner CLI"
  echo "======================================"
  echo "Syntax: run-local-neo4j [command]"
  echo
  echo "---commands---"
  echo "help                   Print CLI help"
  echo "start                  Start local Docker Neo4j database"
  echo "stop                   Stop local Docker Neo4j database"
  echo "cypher_shell           Open Cypher shell in local Docker Neo4j database"
  echo
}

main "$@"
