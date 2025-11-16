#!/bin/bash
set -e

echo "🚀 Initializing ComfyUI..."

# Директория для встроенных custom_nodes
BUILTIN_CUSTOM_NODES="/app/custom_nodes_builtin"
CUSTOM_NODES_DIR="/app/custom_nodes"

# Если custom_nodes пустая или не существует, копируем встроенные
if [ ! -d "$CUSTOM_NODES_DIR" ] || [ -z "$(ls -A $CUSTOM_NODES_DIR 2>/dev/null)" ]; then
    echo "📦 Copying built-in custom nodes to volume..."
    mkdir -p "$CUSTOM_NODES_DIR"
    if [ -d "$BUILTIN_CUSTOM_NODES" ]; then
        cp -r "$BUILTIN_CUSTOM_NODES"/* "$CUSTOM_NODES_DIR/" 2>/dev/null || true
        echo "✅ Built-in custom nodes copied"
    fi
else
    echo "✅ Custom nodes directory already exists, skipping copy"
fi

# Устанавливаем зависимости из всех requirements.txt в custom_nodes
echo "📚 Installing dependencies from custom_nodes..."
find "$CUSTOM_NODES_DIR" -name "requirements.txt" -type f | while read req_file; do
    echo "  → Installing from: $req_file"
    pip install --no-cache-dir -r "$req_file" 2>&1 | grep -E "(Successfully installed|Requirement already satisfied|ERROR)" || true
done

echo "🎨 Starting ComfyUI..."
echo ""

# Запускаем основное приложение
exec "$@"

