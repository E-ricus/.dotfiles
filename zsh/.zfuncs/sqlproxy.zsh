sql_proxy_connect() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: sql_proxy_connect <db_name> <env>"
        return 1
    fi

    local port="1234"
    if [[ -n "$3" ]]; then
        port="$3"
    fi

    local connection=""
    case "$1" in
      fulfillment)
        connection="flink-core-${2}:europe-west3:fulfillment"
        ;;
      flow-management)
        connection="flink-rider-engagement-${2}:europe-west3:flow-management"
        ;;
      rider-state)
        connection="flink-ridertech-${$2}:europe-west3:rider-state-service-${$2}"
        ;;
      equipment)
        connection="flink-rider-engagement-${$2}:europe-west3:rider-equipment"
        ;;
      fleet)
        connection="flink-fleet-management-${$2}:europe-west3:fleet-management-${$2}"
        ;;
      *)
        echo "Undefined db"
        return 1
        ;;
    esac
    local cmd="$HOME/cloud-sql-proxy --address 0.0.0.0 --port $port $connection"
    echo "Connecting to $cmd"
    eval $cmd
}
