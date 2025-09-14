using UnityEngine;

public class CollectibleSphere : MonoBehaviour
{
    public Material shaderMaterial;  // Assign in Inspector
    private static int collectedCount = 0;
    private static int totalSpheres = 5;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            // Apply sphere material to player
            Renderer playerRenderer = other.GetComponent<Renderer>();
            if (playerRenderer != null && shaderMaterial != null)
            {
                playerRenderer.material = shaderMaterial;
            }

            collectedCount++;
            Destroy(gameObject);

            // Check win condition
            if (collectedCount >= totalSpheres)
            {
                Debug.Log("Game Over! All spheres collected!");
            }
        }
    }
}
